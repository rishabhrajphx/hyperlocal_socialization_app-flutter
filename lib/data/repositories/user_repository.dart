import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../models/user.dart';
//import '../services/firebase_service.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final auth.FirebaseAuth _auth;
  final String _usersCollection = 'users';
  final String _friendsCollection = 'friends';

  UserRepository({
    FirebaseFirestore? firestore,
    auth.FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = firebaseAuth ?? auth.FirebaseAuth.instance;

  // Get current user
  User? get currentUser {
    final authUser = _auth.currentUser;
    if (authUser == null) return null;
    return User(
      id: authUser.uid,
      email: authUser.email ?? '',
      name: authUser.displayName ?? '',
      photoUrl: authUser.photoURL,
    );
  }

  // Send friend invite
  Future<void> sendFriendInvite(String userId) async {
    try {
      final currentUserId = _auth.currentUser?.uid;
      if (currentUserId == null) {
        throw Exception('No authenticated user found');
      }

      final batch = _firestore.batch();
      
      // Create friend request
      final requestRef = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection('friendRequests')
          .doc(currentUserId);

      batch.set(requestRef, {
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
        'senderId': currentUserId,
      });

      // Add to sent requests
      final sentRequestRef = _firestore
          .collection(_usersCollection)
          .doc(currentUserId)
          .collection('sentFriendRequests')
          .doc(userId);

      batch.set(sentRequestRef, {
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
        'recipientId': userId,
      });

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to send friend invite: $e');
    }
  }

  // Accept friend request
  Future<void> acceptFriendRequest(String friendId) async {
    try {
      final currentUserId = _auth.currentUser?.uid;
      if (currentUserId == null) {
        throw Exception('No authenticated user found');
      }

      final batch = _firestore.batch();

      // Add to current user's friends
      final currentUserFriendRef = _firestore
          .collection(_usersCollection)
          .doc(currentUserId)
          .collection(_friendsCollection)
          .doc(friendId);

      batch.set(currentUserFriendRef, {
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'accepted',
      });

      // Add to friend's friends list
      final friendRef = _firestore
          .collection(_usersCollection)
          .doc(friendId)
          .collection(_friendsCollection)
          .doc(currentUserId);

      batch.set(friendRef, {
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'accepted',
      });

      // Delete friend request
      final requestRef = _firestore
          .collection(_usersCollection)
          .doc(currentUserId)
          .collection('friendRequests')
          .doc(friendId);

      batch.delete(requestRef);

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to accept friend request: $e');
    }
  }

  // Get friends list
  Stream<List<User>> getFriendsList() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) {
      throw Exception('No authenticated user found');
    }

    return _firestore
        .collection(_usersCollection)
        .doc(currentUserId)
        .collection(_friendsCollection)
        .snapshots()
        .asyncMap((snapshot) async {
          final friendIds = snapshot.docs.map((doc) => doc.id).toList();
          if (friendIds.isEmpty) return [];

          final friendsData = await Future.wait(
            friendIds.map((id) => _firestore
                .collection(_usersCollection)
                .doc(id)
                .get()),
          );

          return friendsData
              .where((doc) => doc.exists)
              .map((doc) => User.fromFirestore(doc))
              .toList();
        });
  }

  // Get friend requests
  Stream<List<FriendRequest>> getFriendRequests() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) {
      throw Exception('No authenticated user found');
    }

    return _firestore
        .collection(_usersCollection)
        .doc(currentUserId)
        .collection('friendRequests')
        .snapshots()
        .asyncMap((snapshot) async {
          final requests = await Future.wait(
            snapshot.docs.map((doc) async {
              final senderData = await _firestore
                  .collection(_usersCollection)
                  .doc(doc.id)
                  .get();
              
              return FriendRequest(
                id: doc.id,
                sender: User.fromFirestore(senderData),
                status: doc.data()['status'] as String,
                timestamp: (doc.data()['timestamp'] as Timestamp).toDate(),
              );
            }),
          );

          return requests;
        });
  }
}

class FriendRequest {
  final String id;
  final User sender;
  final String status;
  final DateTime timestamp;

  FriendRequest({
    required this.id,
    required this.sender,
    required this.status,
    required this.timestamp,
  });
} 
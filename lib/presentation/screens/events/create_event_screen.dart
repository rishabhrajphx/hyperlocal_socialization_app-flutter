class CreateEventScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Apple-style form inputs
          SliverToBoxAdapter(
            child: Form(
              child: Column(
                children: [
                  CupertinoTextField(
                    placeholder: 'Event Name',
                    // Apple-style text input
                  ),
                  // More form fields...
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
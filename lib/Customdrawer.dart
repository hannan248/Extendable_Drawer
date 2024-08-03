import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isExpanded = false;
  bool isOpened = false;
  IconData? selectedIcon; // Variable to keep track of selected icon

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void selectIcon(IconData icon) {
    setState(() {
      selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            setState(() {
              isOpened = !isOpened;
              if (!isOpened) isExpanded = false;
            });
          },
        ),
      ),
      body: Stack(
        children: [
          // Your main content
          const Center(child: Text("Main content")),
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isOpened ? (isExpanded ? 200 : 70) : 0,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isOpened
                    ? (isExpanded ? mainColumn() : iconColumn())
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      key: const ValueKey<String>('iconColumn'),
      children: [
        iconButton(Icons.person_outline),
        iconButton(Icons.home_outlined),
        iconButton(Icons.message_outlined),
        iconButton(Icons.search),
        iconButton(Icons.settings),
        iconButton(Icons.info),
        IconButton(
          onPressed: toggleExpansion,
          icon: Icon(
            isExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget mainColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      key: const ValueKey<String>('mainColumn'),
      children: [
        const SizedBox(
          height: 30,
        ),
        mainListTile(Icons.person_outline, "Person"),
        mainListTile(Icons.home_outlined, "Home"),
        mainListTile(Icons.message_outlined, "Message"),
        mainListTile(Icons.search, "Search"),
        mainListTile(Icons.settings, "Settings"),
        mainListTile(Icons.info, "About"),
        IconButton(
          onPressed: toggleExpansion,
          icon: Icon(
            isExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget iconButton(IconData icon) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: IconButton(
          onPressed: () {
            selectIcon(icon);
          },
          icon: Icon(
            icon,
            size: 30,
            color: selectedIcon == icon ? Colors.blue : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget mainListTile(IconData icon, String title) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              selectIcon(icon);
            },
            icon: Icon(
              icon,
              size: 30,
              color: selectedIcon == icon ? Colors.blue : Colors.white,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedIcon == icon ? Colors.blue : Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

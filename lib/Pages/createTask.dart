import 'package:checkit/Entities/Check.dart';
import 'package:checkit/Entities/Enums/Priority.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final FireStore _fireStore = FireStore();
  Priorities _selectedPriority = Priorities.none;

  List<String> categories = [];

  final _check = Check();

  final _titleController = TextEditingController();
  final _rememberController = TextEditingController();

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final snapshot = await _fireStore.readCollection('Category');
    setState(() {
      categories = snapshot.docs.map((doc) => doc['Title'] as String).toList();
    });
  }

  Future<void> _addCheckToDB() async {
    _check.category = _selectedCategory;
    _check.dateTime = DateTime.now();
    _check.done = false;
    _check.priority = _selectedPriority.name;
    _check.remember = int.tryParse(_rememberController.text);
    _check.title = _titleController.text;
    _check.userid = FirebaseAuth.instance.currentUser?.uid;

    await _fireStore.create('Check', _check.toFirestore());

    _titleController.clear();
    _rememberController.clear();

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/try23.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Add new Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Organize your work and stay productive.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // TITLE
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormFieldWithStyling(
                      needsExpanding: false,
                      hintText: 'Enter task title',
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Color(0xFFBE4C8F),
                      ),
                      controller: _titleController,
                      textInputType: TextInputType.text,
                    ),

                    const SizedBox(height: 20),

                    // REMEMBER
                    const Text(
                      'Reminder',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormFieldWithStyling(
                      needsExpanding: false,
                      hintText: 'Reminder in days',
                      icon: const Icon(
                        Icons.alarm_outlined,
                        color: Color(0xFFBE4C8F),
                      ),
                      controller: _rememberController,
                      textInputType: TextInputType.number,
                    ),

                    const SizedBox(height: 28),

                    // CATEGORY
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: categories.map((category) {
                        final isSelected = _selectedCategory == category;

                        return ChoiceChip(
                          label: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFFBE4C8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 28),

// PRIORITY
                    const Text(
                      'Priority',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Column(
                      children: [
                        CheckboxListTile(
                          value: _selectedPriority == Priorities.high,
                          activeColor: Colors.red,
                          dense: true,
                          visualDensity: VisualDensity(vertical: -2),
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          title: const Text(
                            'High Priority',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          secondary: const Icon(
                            Icons.priority_high,
                            color: Colors.red,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value == true
                                  ? Priorities.high
                                  : Priorities.none;
                            });
                          },
                        ),
                        CheckboxListTile(
                          value: _selectedPriority == Priorities.medium,
                          activeColor: Colors.orange,
                          dense: true,
                          visualDensity: VisualDensity(vertical: -2),
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          title: const Text(
                            'Medium Priority',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          secondary: const Icon(
                            Icons.remove,
                            color: Colors.orange,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value == true
                                  ? Priorities.medium
                                  : Priorities.none;
                            });
                          },
                        ),
                        CheckboxListTile(
                          value: _selectedPriority == Priorities.low,
                          activeColor: Colors.green,
                          dense: true,
                          visualDensity: VisualDensity(vertical: -2),
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          title: const Text(
                            'Low Priority',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          secondary: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.green,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value == true
                                  ? Priorities.low
                                  : Priorities.none;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBE4C8F),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _addCheckToDB,
                            child: const Text(
                              'Create Task',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

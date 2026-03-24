import 'package:flutter/material.dart';
import 'package:focusify_app/shared/widgets/header/header.dart';
import 'package:focusify_app/shared/widgets/title_section/title_section.dart';

class Task {
  String title;
  String category;
  bool done;

  Task({required this.title, required this.category, this.done = false});
}

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleDone;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggleDone,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  gradient: task.done
                      ? LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.8),
                          ],
                        )
                      : null,
                  color: task.done ? null : Colors.transparent,
                  border: Border.all(color: theme.colorScheme.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: task.done
                    ? Icon(
                        Icons.check,
                        size: 20,
                        color: theme.colorScheme.onPrimary,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: task.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onEdit();
                if (value == 'delete') onDelete();
                if (value == 'done') onToggleDone();
              },
              icon: Icon(
                Icons.more_vert,
                color: theme.textTheme.bodyMedium?.color,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit, size: 20),
                    title: Text('Editar'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete, size: 20),
                    title: Text('Eliminar'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'done',
                  child: ListTile(
                    leading: Icon(Icons.check_circle_outline, size: 20),
                    title: Text('Finalizar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [
    Task(title: 'Design editorial interface', category: 'Due Today'),
    Task(title: 'Refine typography scale', category: 'Productivity'),
    Task(title: 'Morning mindfulness', category: 'Personal'),
    Task(title: 'Draft sanctuary docs', category: 'Deep Work'),
  ];

  List<String> categories = [
    'All',
    'Due Today',
    'Productivity',
    'Personal',
    'Deep Work',
  ];

  String selectedCategory = 'All';

  void showAddTaskModal({Task? taskToEdit}) {
    String taskTitle = taskToEdit?.title ?? '';
    String category = taskToEdit?.category ?? '';
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              taskToEdit == null ? 'Nueva Tarea' : 'Editar Tarea',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: taskTitle),
              style: TextStyle(color: theme.textTheme.bodyMedium?.color),
              decoration: InputDecoration(
                labelText: 'Nombre de la tarea',
                filled: true,
                fillColor: theme.colorScheme.surface.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => taskTitle = value,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: category),
              style: TextStyle(color: theme.textTheme.bodyMedium?.color),
              decoration: InputDecoration(
                labelText: 'Categoría',
                filled: true,
                fillColor: theme.colorScheme.surface.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => category = value,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (taskTitle.isNotEmpty) {
                    setState(() {
                      String catToUse = category.isEmpty
                          ? 'Personal'
                          : category;
                      if (!categories.contains(catToUse)) {
                        categories.add(catToUse);
                      }

                      if (taskToEdit != null) {
                        taskToEdit.title = taskTitle;
                        taskToEdit.category = catToUse;
                      } else {
                        tasks.add(Task(title: taskTitle, category: catToUse));
                      }
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text(taskToEdit == null ? 'Agregar' : 'Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    List<Task> filteredTasks = selectedCategory == 'All'
        ? tasks
        : tasks.where((task) => task.category == selectedCategory).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Header(title: 'Tareas', icon: Icons.checklist),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const TitleSection(
              title: "Tema del día",
              subtitle:
                  'Tus intenciones: Hacer una cosa a la vez es el refugio de la mente.',
              description:
                  'Concéntrate en una tarea a la vez y completa cada una con propósito.',
            ),
            const SizedBox(height: 16),
            // Tabs de categorías
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String cat = categories[index];
                  bool isSelected = cat == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surface.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: isSelected
                                ? colorScheme.onPrimary
                                : theme.textTheme.bodyMedium?.color,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // LISTVIEW que incluye TAREAS + FRASE
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length + 1, // +1 para la frase
                itemBuilder: (context, index) {
                  if (index < filteredTasks.length) {
                    final task = filteredTasks[index];
                    return TaskCard(
                      task: task,
                      onEdit: () => showAddTaskModal(taskToEdit: task),
                      onDelete: () => setState(() => tasks.remove(task)),
                      onToggleDone: () =>
                          setState(() => task.done = !task.done),
                    );
                  } else {
                    // FRASE AL FINAL DEL SCROLL
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colorScheme.primary.withValues(alpha: 0.1),
                              colorScheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: colorScheme.primary,
                              child: Icon(
                                Icons.star,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '“La organización de lo no obvio es el secreto de toda victoria.”',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '- Marcus Aurelius',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.textTheme.bodySmall?.color
                                    ?.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskModal(),
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
      ),
    );
  }
}

import 'dart:io';
import '../lib/todo_repository.dart';
import '../lib/todo.dart';

void main() {
  TodoRepository repo = TodoRepository();
  printMenu();
  while (true) {
    stdout.write('> ');
    String? input = stdin.readLineSync();
    if (input == null) {
      continue;
    }
    input = input.trim();
    if (input.isEmpty) {
      continue;
    }
    bool shouldExit = handleCommand(repo, input);
    if (shouldExit) {
      break;
    }
  }
}

void printMenu() {
  print('Приложение TODO');
  print('Команды');
  print('add <текст>  -добавить задачу');
  print('list показать список');
  print('done<id> отметить выполненой');
  print('delete удалить задачу');
  print('exit выход');
}

void addCommand(TodoRepository repo, String input) {
  if (input.length <= 4) {
    print('Ошибка: введите текст');
    return;
  }
  String title = input.substring(4).trim();
  repo.add(title);
  print('Задача добавлена');
}

void listCommand(TodoRepository repo) {
  List<Todo> todos = repo.getAll();
  if (todos.isEmpty) {
    print('Список задач пуст');
    return;
  }
  for (var todo in todos) {
    print(todo);
  }
}

void doneCommand(TodoRepository repo, List<String> parts) {
  if (parts.length < 2) {
    print("Ошибка: укажите id");
    return;
  }

  int id = int.parse(parts[1]);
  repo.complete(id);
  print("Задача отмечена выполненной");
}

void deleteCommand(TodoRepository repo, List<String> parts) {
  if (parts.length < 2) {
    print("Ошибка: укажите id");
    return;
  }

  int id = int.parse(parts[1]);
  repo.delete(id);
  print("Задача удалена");
}

bool handleCommand(TodoRepository repo, String input) {
  List<String> parts = input.split(" ");
  String command = parts[0].toLowerCase();
  try {
    switch (command) {
      case "add":
        addCommand(repo, input);
        break;
      case "list":
        listCommand(repo);
        break;
      case "done":
        doneCommand(repo, parts);
        break;
      case "delete":
        deleteCommand(repo, parts);
        break;
      case "exit":
        print("Выход из программы");
        return true;
      default:
        print("Неизвестная команда");
    }
  } catch (e) {
    print("Ошибка: $e");
  }
  return false;
}

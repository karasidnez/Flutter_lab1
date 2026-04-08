import 'dart:io';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_repository.dart';
void main() {
  TodoRepository todo = TodoRepository();
  printMenu();
  while(true){
    stdout.write('> ');
    String? input = stdin.readLineSync();
    if(input == null ){
      continue;
    }
    input = input.trim();
    if(input.isEmpty){
      continue;
    }
    bool shouldExit = handleCommand(repo, input);
    if (shouldExit){
      break;
    }
  }
}
void printMenu(){
  print('Приложение TODO');
  print('Команды');
  print('add <текст>  -добавить задачу');
  print('list показать список');
  print('done<id> отметить выполненой');
  print('delete удалить задачу');
  print('exit выход');

}
void addCommand(TodoRepository repo, String input) {
  if(input.length <= 4){
    print('Ошибка: введите текст');
    return;

  }
  String title = input.substring(4).trim();
  repo.add(title);
  print('Задача добавлена');

}
void listCommand(TodoRepository repo){
  List<Todo> todos = repo.getAll();
  if(todos.isEmpty){
    print('Список задач пуст');
    return;
  }
  for(var todo in todos) {
    print(todo)
  }
} 

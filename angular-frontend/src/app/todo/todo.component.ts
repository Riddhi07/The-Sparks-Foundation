import {Component, OnInit} from '@angular/core';
import {TaskStorageService} from "../task-storage.service";
import {Task} from "../shared/models/task.model";

@Component({
  selector: 'app-todo',
  templateUrl: './todo.component.html',
  styleUrls: ['./todo.component.css']
})
export class TodoComponent implements OnInit {

  tasks: Task[];

  constructor(private storage: TaskStorageService) {
    this.ngOnInit();
  }

  /**
   * Load tasks on init
   */
  ngOnInit() : void{
    this.storage.getTasks().subscribe((data: any) => {
      this.tasks = data.data;
      console.log(this.tasks);
    });

  }

  /**
   * Remove the tasks from the list
   *
   * @param id task index to remove
   */
  delete(id): void {
    this.storage.delete(id).subscribe((data: any) => {
      
      console.log(data);
      console.log(this.tasks);
      this.ngOnInit();
    });;
   
  }
}

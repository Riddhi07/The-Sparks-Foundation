import {Component} from '@angular/core';
import {FormControl} from '@angular/forms';
import {TaskStorageService} from "../task-storage.service";
import {Router} from '@angular/router';

@Component({
  selector: 'app-task-add',
  templateUrl: './task-add.component.html',
  styleUrls: ['./task-add.component.css']
})
export class TaskAddComponent {

  /**
   * Task title form field
   */
  title = new FormControl('');

  /**
   *  Task note form field
   */
  

  constructor(private storage: TaskStorageService, private router: Router) {
  }

  /**
   * Create a task a redirect to the todo list
   */
  createTask() {
    this.storage.add(this.title.value).subscribe((data: any) => {
       
      console.log(data.data);
    });
;
    this.router.navigate(['/tasks'])
  }
}

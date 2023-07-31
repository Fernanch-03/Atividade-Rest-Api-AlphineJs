<%-- 
    Document   : index
    Created on : 8 de mai. de 2023, 14:13:19
    Author     : Fatec
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap demo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    </head>
    <body>
        <script>
            async function request(url = "", methd, data) {
                const response = await fetch(url, {
                    method: methd,
                    headers: {"Content-Type": "application/json", },
                    body: JSON.stringify(data)
                });
                return response.json();
            }
            function tasks(){
                return{
                    newTaskTitle:'',
                    list: [],
                    async loadTasks(){
                        request("/Rest_Api_AlphineJS/tasks","GET").then((data)=>{
                            this.list = data.list;
                        });    
                    },
                    async addTasks(){
                        request("/Rest_Api_AlphineJS/tasks","PUT",{title: this.newTaskTitle}).then((data)=>{
                            this.newTaskTitle = '';
                            this.list = data.list;
                        });
                    },
                    async removeTasks(taskTitle){
                        request("/Rest_Api_AlphineJS/tasks?title="+taskTitle,"DELETE").then((data)=>{
                            this.list = data.list;
                        });
                    }
                }
            }
        </script>
        <nav class="navbar bg-body-tertiary">
            <div class="container-fluid">
                <span class="navbar-brand mb-0 h1">My tasks</span>
            </div>
        </nav>
        <div x-data="tasks()" x-init="loadTasks()">
            <div>
                <input type="text" x-model="newTaskTitle" placeholder="New Task">
                <button type="button" x-on:click ="addTasks()">+</button>
            </div>
            <table class="table">
            <template x-for="task in list">
                <tr>
                    <td>
                        <button type="button" x-on:click ="removeTasks(task.title)">Done</button>
                        <span x-text = "task.title"></span>
                    </td>
                </tr>
            </template>
        </table>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    </body>
</html>


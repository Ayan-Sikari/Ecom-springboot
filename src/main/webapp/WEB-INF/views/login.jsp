<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        * {
            box-sizing: border-box;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        #app {
            width: 380px;
            padding: 30px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            color: #fff;
        }

        h1 {
            text-align: center;
            margin-bottom: 5px;
            font-size: 24px;
        }

        h3 {
            text-align: center;
            font-weight: normal;
            margin-top: 0;
            opacity: 0.85;
        }

        hr {
            border: none;
            height: 1px;
            background: rgba(255, 255, 255, 0.3);
            margin: 20px 0;
        }

        label {
            font-size: 14px;
            opacity: 0.9;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            margin-top: 6px;
            border-radius: 8px;
            border: none;
            outline: none;
            background: rgba(255, 255, 255, 0.25);
            color: #fff;
            font-size: 14px;
        }

        input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        select option {
            color: #000;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border-radius: 10px;
            border: none;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            color: #fff;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }

        span {
            font-size: 12px;
        }

        p {
            text-align: center;
            margin-top: 15px;
        }
    </style>

</head>

<body>

<div id="app">
    <h1>User Authentication System</h1>
    <h3>Login Page</h3>

    <hr>

    <form action="/auth/login" method="post" @submit.prevent="validateForm">

        <label><b>User Email</b></label><br>
        <input type="email" name="username" v-model="email" placeholder="Enter email">
        <br>
        <span style="color:red">{{ errors.email }}</span>

        <br><br>

        <label><b>Password</b></label><br>
        <input type="password" name="password" v-model="password" placeholder="Enter password">
        <br>
        <span style="color:red">{{ errors.password }}</span>

        <br><br>

        <label><b>Role</b></label><br>
        <select name="role" v-model="role">
            <option value="">-- Select Role --</option>
            <option value="ADMIN">ADMIN</option>
            <option value="USER">USER</option>
            <option value="MANAGER">MANAGER</option>
        </select>
        <br>
        <span style="color:red">{{ errors.role }}</span>

        <br><br>

        <button type="submit">Login</button>
    </form>

    <br>
    <p style="color:red"><b>${error}</b></p>
</div>

<script>
const { createApp } = Vue;

createApp({
    data() {
        return {
            email: '',
            password: '',
            role: '',
            errors: {
                email: '',
                password: '',
                role: ''
            }
        }
    },
    methods: {
        validateForm() {
            this.errors.email = '';
            this.errors.password = '';
            this.errors.role = '';
            let isValid = true;
            if (!this.email) {
                this.errors.email = 'Email cannot be blank';
                isValid = false;
            } else if (!this.email.endsWith('@test.com')) {
                this.errors.email = 'Email must end with @test.com';
                isValid = false;
            }
            if (!this.password) {
                this.errors.password = 'Password cannot be blank';
                isValid = false;
            }
            if (!this.role) {
                this.errors.role = 'Please select a role';
                isValid = false;
            }
            if (isValid) {
                document.querySelector('form').submit();
            }
        }
    }
}).mount('#app');
</script>

</body>
</html>

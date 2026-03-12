<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>My Account</title>
</head>

<body>

<h2>My Account</h2>

<p><b>Username:</b> ${user.username}</p>
<p><b>Email:</b> ${user.mail}</p>
<p><b>Role:</b> ${user.role}</p>

<hr/>

<h3>Account Options</h3>

<ul>
    <li>
        <a href="/orders">My Orders</a>
    </li>

    <li>
        <a href="/cart/view">My Cart</a>
    </li>
</ul>

</body>
</html>
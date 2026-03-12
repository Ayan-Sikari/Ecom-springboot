<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="comp" tagdir="/WEB-INF/tags/components" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 15px 25px;
        }

        .user-info {
            text-align: right;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-top: 80px;
        }

        .card {
            border: 1px solid #ddd;
            padding: 14px;
            border-radius: 8px;
        }

        .original-price {
            text-decoration: line-through;
            color: #777;
            margin-right: 6px;
        }

        .discounted-price {
            font-size: 22px;
            font-weight: bold;
            color: #2e7d32;
        }

        .discount {
            color: #d32f2f;
            font-size: 13px;
            margin-left: 6px;
        }

        .out-of-stock {
            color: red;
            font-weight: bold;
        }

        .in-stock {
            color: green;
            font-weight: bold;
        }

        button {
            padding: 6px 10px;
            border: none;
            cursor: pointer;
            margin-top: 6px;
        }

        .notify-btn {
            background-color: #ff9800;
        }

        .buy-btn {
            background-color: #2e7d32;
            color: white;
        }
    </style>
</head>

<body>

<div class="header">
    <h1>Welcome to Store</h1>
    <div style="position:relative; float:right; margin-right:20px;">
        <a href="/orders">📦 My Orders</a>

        <a href="/cart/view" style="text-decoration:none; font-size:22px;">
            🛒
        </a>

        <c:if test="${not empty sessionScope.user.cart.items}">
        <span style="
            position:absolute;
            top:-8px;
            right:-10px;
            background:red;
            color:white;
            font-size:12px;
            padding:2px 6px;
            border-radius:50%;
        ">
                ${fn:length(sessionScope.user.cart.items)}
        </span>
        </c:if>

    </div>
    <div class="user-info">
        <b>
            <a href="/account" style="font-weight:bold; text-decoration:none; color:black;">
                ${username}
            </a>
        </b>
        <br>
        <i>Role: ${role}</i><br>
        <p>
                    Last Login at:
                    <fmt:formatDate value="${loginTime}" pattern="dd/MM/yyyy HH:mm:ss" timeZone="GMT+05:30"/>
        </p>

        <a href="/logout">Logout</a>
    </div>
</div>

<c:choose>

    <c:when test="${not empty selectedItem}">
        <comp:itemDetails item="${selectedItem}" />
    </c:when>

    <c:otherwise>
        <comp:itemGrid items="${items}" />
    </c:otherwise>

</c:choose>
</body>
</html>


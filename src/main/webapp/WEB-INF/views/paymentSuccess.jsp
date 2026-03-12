<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Successful</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 30px;
        }
        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            max-width: 560px;
            width: 100%;
            padding: 40px 35px;
            text-align: center;
        }

        .check-circle {
            width: 75px; height: 75px;
            background: #28a745;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            font-size: 38px;
            color: white;
        }
        h1 { font-size: 26px; color: #222; margin-bottom: 8px; }
        .subtitle { color: #666; font-size: 15px; margin-bottom: 28px; }

        .order-info {
            background: #f8f9fa;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 16px 20px;
            text-align: left;
            margin-bottom: 24px;
        }
        .order-info h3 {
            font-size: 14px;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 12px;
        }
        .order-info .row {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            padding: 5px 0;
            border-bottom: 1px solid #eee;
        }
        .order-info .row:last-child { border-bottom: none; }
        .order-info .row span:first-child { color: #555; }
        .order-info .row span:last-child { font-weight: bold; color: #222; }

        .items-section { text-align: left; margin-bottom: 24px; }
        .items-section h3 {
            font-size: 14px;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
        }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th {
            background: #f2f2f2;
            padding: 8px 10px;
            text-align: left;
            color: #555;
            font-weight: normal;
        }
        td { padding: 8px 10px; border-bottom: 1px solid #f0f0f0; color: #333; }
        .total-row td {
            font-weight: bold;
            border-top: 2px solid #ddd;
            border-bottom: none;
            font-size: 15px;
        }

        .btn-primary {
            display: block;
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 15px;
            margin-bottom: 10px;
            transition: background 0.2s;
        }
        .btn-primary:hover { background: #0056b3; }
        .btn-secondary {
            display: block;
            width: 100%;
            padding: 12px;
            background: white;
            color: #555;
            text-decoration: none;
            border-radius: 6px;
            font-size: 15px;
            border: 1px solid #ccc;
            transition: background 0.2s;
        }
        .btn-secondary:hover { background: #f2f2f2; }

        .secure-note {
            margin-top: 20px;
            font-size: 12px;
            color: #aaa;
        }
    </style>
</head>
<body>
<div class="card">

    <div class="check-circle">✓</div>
    <h1>Payment Successful 🎉</h1>
    <p class="subtitle">
        Thank you, <c:out value="${sessionScope.username}"/>!
        Your order has been placed successfully.
    </p>

    <div class="order-info">
        <h3>Order Details</h3>

        <c:if test="${not empty order.orderId}">
            <div class="row">
                <span>Order ID</span>
                <span>#<c:out value="${order.orderId}"/></span>
            </div>
        </c:if>

        <div class="row">
            <span>Date</span>
            <span>
                <c:choose>
                    <c:when test="${not empty order.orderDate}">
                        <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/>
                    </c:when>
                    <c:otherwise>
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="dd MMM yyyy, hh:mm a"/>
                    </c:otherwise>
                </c:choose>
            </span>
        </div>

        <c:if test="${not empty order.paymentMethod}">
            <div class="row">
                <span>Payment Method</span>
                <span><c:out value="${order.paymentMethod}"/></span>
            </div>
        </c:if>

        <div class="row">
            <span>Status</span>
            <span style="color: #28a745;">✔ Confirmed</span>
        </div>
    </div>

    <c:if test="${not empty order.items}">
        <div class="items-section">
            <h3>Items Ordered</h3>
            <table>
                <tr>
                    <th>Item</th>
                    <th>Qty</th>
                    <th style="text-align:right;">Price</th>
                </tr>
                <c:forEach var="ci" items="${order.items}">
                    <tr>
                        <td><c:out value="${ci.item.itemName}"/></td>
                        <td><c:out value="${ci.quantity}"/></td>
                        <td style="text-align:right;">₹ <c:out value="${ci.totalPrice}"/></td>
                    </tr>
                </c:forEach>
                <tr class="total-row">
                    <td colspan="2">Total Paid</td>
                    <td style="text-align:right;">₹ <c:out value="${order.total}"/></td>
                </tr>
            </table>
        </div>
    </c:if>

    <a href="/welcome" class="btn-primary">Continue Shopping</a>
    <c:if test="${not empty order.orderId}">
        <a href="/orders/${order.orderId}" class="btn-secondary">View Order Details</a>
    </c:if>

    <p class="secure-note">🔒 A confirmation will be sent to your registered email.</p>

</div>
</body>
</html>
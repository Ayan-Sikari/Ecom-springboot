<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f4f6f8; padding: 40px 20px; }

        .container { max-width: 780px; margin: 0 auto; }
        h2 { font-size: 26px; color: #222; margin-bottom: 6px; }
        .subtitle { font-size: 14px; color: #888; margin-bottom: 28px; }

        .empty-box {
            background: white; border-radius: 10px; padding: 50px 20px;
            text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.07);
        }
        .empty-box p { color: #888; font-size: 15px; margin-bottom: 16px; }
        .empty-box a {
            padding: 10px 22px; background: #007bff; color: white;
            border-radius: 5px; text-decoration: none; font-size: 14px;
        }
        .empty-box a:hover { background: #0056b3; }

        .order-card {
            background: white; border-radius: 10px; margin-bottom: 22px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden;
        }

        .card-header {
            display: flex; justify-content: space-between; align-items: center;
            flex-wrap: wrap; gap: 10px;
            background: #f8f9fa; padding: 14px 20px;
            border-bottom: 1px solid #eee;
        }
        .card-header .order-id { font-size: 15px; font-weight: bold; color: #333; }
        .card-header .order-date { font-size: 13px; color: #888; }

        .badge {
            padding: 4px 12px; border-radius: 20px;
            font-size: 12px; font-weight: bold; text-transform: uppercase;
        }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-pending { background: #fff3cd; color: #856404; }
        .badge-failed  { background: #f8d7da; color: #721c24; }
        .badge-default { background: #e2e3e5; color: #383d41; }

        .card-body { padding: 18px 20px; }

        .meta-row {
            display: flex; gap: 30px; flex-wrap: wrap;
            margin-bottom: 16px; font-size: 14px; color: #555;
        }
        .meta-row span strong { color: #222; }

        .card-body h4 { font-size: 13px; color: #888;
            text-transform: uppercase; margin-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #f2f2f2; padding: 9px 12px;
            text-align: left; color: #555; font-weight: 600; }
        td { padding: 9px 12px; border-bottom: 1px solid #f0f0f0; color: #333; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #fafafa; }

        .total-row td {
            font-weight: bold; font-size: 15px;
            border-top: 2px solid #eee; background: #fafafa;
        }

        .card-footer {
            padding: 12px 20px; border-top: 1px solid #eee;
            text-align: right; background: #fafafa;
        }
        .btn-outline {
            padding: 7px 18px; border: 1px solid #007bff; color: #007bff;
            border-radius: 5px; text-decoration: none; font-size: 13px;
        }
        .btn-outline:hover { background: #007bff; color: white; }

        .back-link {
            display: inline-block; margin-bottom: 20px;
            color: #007bff; text-decoration: none; font-size: 14px;
        }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">

    <a href="/welcome" class="back-link">← Back to Shopping</a>
    <h2>📦 My Orders</h2>

    <c:choose>

        <c:when test="${empty orders}">
            <div class="empty-box">
                <p>You haven't placed any orders yet.</p>
                <a href="/welcome">Start Shopping</a>
            </div>
        </c:when>

        <c:otherwise>
            <p class="subtitle">
                Showing <strong>${fn:length(orders)}</strong> order(s)
            </p>

            <c:forEach var="order" items="${orders}" varStatus="status">
                <div class="order-card">

                    <div class="card-header">
                        <div>
                            <span class="order-id">
                                Order #<c:out value="${order.orderId}"/>
                            </span>
                            <span class="order-date" style="margin-left:12px;">
                                <c:choose>
                                    <c:when test="${not empty order.orderDate}">
                                        <fmt:formatDate value="${order.orderDate}"
                                                        pattern="dd MMM yyyy, hh:mm a"/>
                                    </c:when>
                                    <c:otherwise>N/A</c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <c:choose>
                            <c:when test="${order.paymentStatus == 'SUCCESS'}">
                                <span class="badge badge-success">✔ Paid</span>
                            </c:when>
                            <c:when test="${order.paymentStatus == 'PENDING'}">
                                <span class="badge badge-pending">⏳ Pending</span>
                            </c:when>
                            <c:when test="${order.paymentStatus == 'FAILED'}">
                                <span class="badge badge-failed">✘ Failed</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-default">
                                    <c:out value="${order.paymentStatus}"/>
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card-body">

                        <div class="meta-row">
                            <span>Order No: <strong>${status.count}</strong></span>
                            <span>Items: <strong>${fn:length(order.items)}</strong></span>
                            <span>Amount: <strong>₹ <c:out value="${order.totalAmount}"/></strong></span>
                        </div>

                        <h4>Items Ordered</h4>
                        <c:choose>
                            <c:when test="${empty order.items}">
                                <p style="color:#aaa; font-size:13px;">
                                    No item details available.
                                </p>
                            </c:when>
                            <c:otherwise>
                                <table>
                                    <tr>
                                        <th>#</th>
                                        <th>Item Name</th>
                                        <th>Quantity</th>
                                        <th style="text-align:right;">Price (₹)</th>
                                    </tr>
                                    <c:forEach var="item" items="${order.items}"
                                               varStatus="itemStatus">
                                        <tr>
                                            <td><c:out value="${itemStatus.count}"/></td>
                                            <td><c:out value="${item.item.itemName}"/></td>
                                            <td><c:out value="${item.quantity}"/></td>
                                            <td style="text-align:right;">
                                                ₹ <c:out value="${item.price}"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="total-row">
                                        <td colspan="3">Total Paid</td>
                                        <td style="text-align:right;">
                                            ₹ <c:out value="${order.totalAmount}"/>
                                        </td>
                                    </tr>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card-footer">
                        <a href="/orders/<c:out value='${order.orderId}'/>"
                           class="btn-outline">View Details →</a>
                    </div>

                </div>
            </c:forEach>

        </c:otherwise>
    </c:choose>

</div>
</body>
</html>
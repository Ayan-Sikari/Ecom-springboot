<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f4f6f8;
            padding: 40px 20px; }

        .container { max-width: 700px; margin: 0 auto; background: white;
            border-radius: 10px; padding: 30px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.08); }

        h2 { font-size: 24px; margin-bottom: 20px; color: #222; }

        .empty-box { text-align: center; padding: 40px 20px; color: #888; }
        .empty-box p { font-size: 16px; margin-bottom: 14px; }
        .empty-box a { color: #007bff; text-decoration: none; font-size: 14px; }
        .empty-box a:hover { text-decoration: underline; }

        table { width: 100%; border-collapse: collapse; font-size: 14px;
            margin-bottom: 20px; }
        th { background: #f2f2f2; padding: 10px 12px;
            text-align: left; color: #555; font-weight: 600; }
        td { padding: 10px 12px; border-bottom: 1px solid #eee; color: #333; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #fafafa; }

        .remove-link { color: #dc3545; text-decoration: none; font-size: 13px; }
        .remove-link:hover { text-decoration: underline; }

        .total-section { text-align: right; margin-bottom: 20px; }
        .total-section h3 { font-size: 18px; color: #222; }

        hr { border: none; border-top: 1px solid #eee; margin-bottom: 20px; }

        .actions { display: flex; justify-content: space-between; align-items: center; }
        .btn-secondary {
            padding: 10px 18px; background: white; color: #555;
            border: 1px solid #ccc; border-radius: 5px;
            text-decoration: none; font-size: 14px;
        }
        .btn-secondary:hover { background: #f2f2f2; }
        .btn-primary {
            padding: 10px 24px; background: #28a745; color: white;
            border-radius: 5px; text-decoration: none;
            font-size: 15px; font-weight: bold;
        }
        .btn-primary:hover { background: #218838; }

        .item-count { font-size: 13px; color: #888; margin-bottom: 16px; }
    </style>
</head>
<body>
<div class="container">

    <h2>🛒 Your Cart</h2>

    <c:choose>
        <c:when test="${empty cart.items}">
            <div class="empty-box">
                <p>Your cart is empty.</p>
                <a href="/welcome">← Browse Items</a>
            </div>
        </c:when>

        <c:otherwise>

            <p class="item-count">
                <c:out value="${fn:length(cart.items)}"/> item(s) in your cart
            </p>

            <table>
                <tr>
                    <th>#</th>
                    <th>Item</th>
                    <th>Unit Price (₹)</th>
                    <th>Quantity</th>
                    <th>Total (₹)</th>
                    <th>Action</th>
                </tr>
                <c:forEach var="ci" items="${cart.items}" varStatus="status">
                    <tr>
                        <td><c:out value="${status.count}"/></td>
                        <td><c:out value="${ci.item.itemName}"/></td>
                        <td><c:out value="${ci.item.itemPrice}"/></td>
                        <td>
                            <a href="/cart/decrease/${ci.item.itemId}">➖</a>

                            <c:out value="${ci.quantity}"/>

                            <a href="/cart/increase/${ci.item.itemId}">➕</a>
                        </td>
                        <td>₹ <c:out value="${ci.totalPrice}"/></td>
                        <td>
                            <a class="remove-link"
                               href="/cart/remove/<c:out value='${ci.item.itemId}'/>"
                               onclick="return confirm('Remove ${ci.item.itemName} from cart?')">
                                Remove
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <hr/>

            <div class="total-section">
                <h3>Grand Total : ₹ <c:out value="${cart.total}"/></h3>
            </div>

            <div class="actions">
                <a href="/welcome" class="btn-secondary">← Continue Shopping</a>
                <a href="/cart/checkout" class="btn-primary">Checkout →</a>
            </div>

        </c:otherwise>
    </c:choose>

</div>
</body>
</html>
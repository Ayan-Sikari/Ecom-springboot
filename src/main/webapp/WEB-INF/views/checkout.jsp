<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background: #f9f9f9; }
        .container { max-width: 550px; background: white; padding: 30px;
            border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { margin-bottom: 5px; }
        h3 { margin-top: 25px; border-bottom: 1px solid #ddd; padding-bottom: 6px; }

        .summary-table { width: 100%; border-collapse: collapse; margin-bottom: 10px; }
        .summary-table td { padding: 6px 4px; font-size: 14px; }
        .summary-table .total-row td { font-weight: bold; border-top: 1px solid #ccc;
            padding-top: 8px; font-size: 15px; }

        label { font-size: 13px; font-weight: bold; color: #444; }
        input { width: 100%; padding: 9px 10px; margin: 5px 0 14px;
            border: 1px solid #ccc; border-radius: 4px;
            box-sizing: border-box; font-size: 14px; }
        input:focus { border-color: #007bff; outline: none; }
        .card-row { display: flex; gap: 15px; }
        .card-row .field { flex: 1; }

        .error { color: red; font-size: 13px; margin-bottom: 10px; }

        .pay-btn { width: 100%; padding: 12px; background: #28a745;
            color: white; font-size: 16px; border: none;
            border-radius: 5px; cursor: pointer; margin-top: 5px; }
        .pay-btn:hover { background: #218838; }
        .back-link { display: block; text-align: center; margin-top: 12px;
            color: #555; font-size: 13px; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
        .secure-note { font-size: 12px; color: #888; text-align: center;
            margin-top: 8px; }
    </style>
</head>
<body>
<div class="container">

    <h2>Checkout</h2>

    <c:if test="${not empty errorMessage}">
        <p class="error"><c:out value="${errorMessage}"/></p>
    </c:if>

    <h3>Order Summary</h3>
    <c:choose>
        <c:when test="${empty cart.items}">
            <p style="color:gray; font-size:14px;">
                Your cart is empty. <a href="/items">Go Shopping</a>
            </p>
        </c:when>
        <c:otherwise>
            <table class="summary-table">
                <c:forEach var="ci" items="${cart.items}">
                    <tr>
                        <td><c:out value="${ci.item.itemName}"/></td>
                        <td>x<c:out value="${ci.quantity}"/></td>
                        <td style="text-align:right;">₹ <c:out value="${ci.totalPrice}"/></td>
                    </tr>
                </c:forEach>
                <tr class="total-row">
                    <td colspan="2">Total</td>
                    <td style="text-align:right;">₹ <c:out value="${cart.total}"/></td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>

    <h3>Payment Details</h3>
    <form action="/cart/pay" method="post" onsubmit="return validateForm()">

        <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}"/>

        <label for="cardHolder">Card Holder Name</label>
        <input type="text"
               id="cardHolder"
               name="cardHolder"
               placeholder="John Doe"
               maxlength="100"
               autocomplete="cc-name"
               required/>

        <label for="cardNumber">Card Number</label>
        <input type="text"
               id="cardNumber"
               name="cardNumber"
               placeholder="1234 5678 9012 3456"
               maxlength="19"
               autocomplete="cc-number"
               inputmode="numeric"
               required/>

        <div class="card-row">
            <div class="field">
                <label for="expiry">Expiry Date</label>
                <input type="text"
                       id="expiry"
                       name="expiry"
                       placeholder="MM/YY"
                       maxlength="5"
                       autocomplete="cc-exp"
                       required/>
            </div>
            <div class="field">
                <label for="cvv">CVV</label>
                <input type="password"
                       id="cvv"
                       name="cvv"
                       placeholder="•••"
                       maxlength="4"
                       autocomplete="cc-csc"
                       inputmode="numeric"
                       required/>
            </div>
        </div>

        <button type="submit" class="pay-btn">
            Pay ₹ <c:out value="${cart.total}"/>
        </button>
    </form>

    <a class="back-link" href="/cart">← Back to Cart</a>
    <p class="secure-note">🔒 Your payment details are encrypted and secure.</p>

</div>

<script>

    document.getElementById('cardNumber').addEventListener('input', function () {
        let val = this.value.replace(/\D/g, '').substring(0, 16);
        this.value = val.replace(/(.{4})/g, '$1 ').trim();
    });

    document.getElementById('expiry').addEventListener('input', function () {
        let val = this.value.replace(/\D/g, '').substring(0, 4);
        if (val.length >= 3) val = val.substring(0, 2) + '/' + val.substring(2);
        this.value = val;
    });

    document.getElementById('cvv').addEventListener('input', function () {
        this.value = this.value.replace(/\D/g, '').substring(0, 4);
    });

    function validateForm() {
        const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
        const expiry    = document.getElementById('expiry').value;
        const cvv       = document.getElementById('cvv').value;
        const holder    = document.getElementById('cardHolder').value.trim();

        if (!/^\d{16}$/.test(cardNumber)) {
            alert('Please enter a valid 16-digit card number.'); return false;
        }
        if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiry)) {
            alert('Please enter expiry in MM/YY format.'); return false;
        }
        if (!/^\d{3,4}$/.test(cvv)) {
            alert('CVV must be 3 or 4 digits.'); return false;
        }
        if (holder.length < 2) {
            alert('Please enter the card holder name.'); return false;
        }
        return true;
    }
</script>

</body>
</html>
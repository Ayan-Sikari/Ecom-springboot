<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="items" required="true" type="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
.item-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 16px;
    margin-top: 20px;
}

.item-card {
    border: 1px solid #ddd;
    padding: 14px;
    border-radius: 8px;
}

.item-original-price {
    text-decoration: line-through;
    color: #777;
    margin-right: 6px;
}

.item-discounted-price {
    font-size: 22px;
    font-weight: bold;
    color: #2e7d32;
}

.item-discount {
    color: #d32f2f;
    font-size: 13px;
    margin-left: 6px;
}

.item-out-of-stock {
    color: red;
    font-weight: bold;
}

.item-in-stock {
    color: green;
    font-weight: bold;
}

.item-btn {
    padding: 6px 10px;
    border: none;
    cursor: pointer;
    margin-top: 6px;
}

.item-notify-btn {
    background-color: #ff9800;
}

.item-buy-btn {
    background-color: #2e7d32;
    color: white;
}
</style>

<div class="item-grid">

    <c:forEach var="item" items="${items}">

        <c:set var="finalPrice"
               value="${item.itemPrice - (item.itemPrice * item.itemDiscount / 100.0)}"/>

        <div class="item-card">

            <a id="item-${item.itemId}" href="${pageContext.request.contextPath}/items/${item.itemId}">
                <h4>${item.itemName}</h4>
            </a>
            <p>${item.itemDescription}</p>

            <div>
                <span class="item-original-price">
                    ${item.itemPrice} Rs.
                </span>
                <br/>
                <span class="item-discounted-price">
                    ₹ <fmt:formatNumber value="${finalPrice}" maxFractionDigits="2" minFractionDigits="2"/>
                </span>
                <br>
                <span class="item-discount">
                    (<fmt:formatNumber value="${item.itemDiscount}" maxFractionDigits="0" minFractionDigits="0"/>% OFF)
                </span>
            </div>

            <c:choose>
                <c:when test="${item.itemQuantity == null or item.itemQuantity eq 0}">
                    <p class="item-out-of-stock">Out of Stock</p>
                    <button class="item-btn item-notify-btn">Notify Me</button>
                </c:when>
                <c:otherwise>
                    <p class="item-in-stock">In Stock</p>
                    <form action="/cart/add/${item.itemId}" method="post">
                        <button class="item-btn item-buy-btn" type="submit">Buy Now</button>
                    </form>
                </c:otherwise>
            </c:choose>

            <p>⭐ ${item.itemRating}</p>

        </div>

    </c:forEach>

</div>
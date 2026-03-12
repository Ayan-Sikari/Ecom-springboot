<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="item" type="com.procoder.authentication1.models.Item" required="true" %>

<div class="item-details">
    <h2>${item.itemName}</h2>

    <p>
        <b>Description:</b>
        ${item.itemDescription}
    </p>

    <p>
        <b>Price:</b>
        ₹${item.itemPrice}
    </p>

    <p>
        <b>Discount:</b>
        ${item.itemDiscount}%
    </p>

    <p>
        <b>Rating:</b>
        ⭐ ${item.itemRating}
    </p>

    <form action="/cart/add/${item.itemId}" method="post">
        <button type="submit">Add To Cart</button>
    </form>
</div>
// Array global en memoria para guardar el carrito de compras
let shoppingCart = [];

// Escucha de eventos una vez cargado el árbol DOM
document.addEventListener("DOMContentLoaded", () => {
    const addButtons = document.querySelectorAll(".btn-add");
    
    addButtons.forEach(button => {
        button.addEventListener("click", (e) => {
            const productItem = e.target.closest(".product-item");
            const id = productItem.getAttribute("data-id");
            const name = productItem.getAttribute("data-name");
            const price = parseFloat(productItem.getAttribute("data-price"));
            
            // Extracción de selectores dinámicos
            const size = productItem.querySelector(".prod-size")?.value || "Única";
            const color = productItem.querySelector(".prod-color")?.value || "Único";
            const style = productItem.querySelector(".prod-style")?.value ? ` (${productItem.querySelector(".prod-style").value})` : "";
            
            const finalSpecs = `${name}${style} [Talla: ${size} / Color: ${color}]`;
            
            // Ejecutar inserción en el carro
            pushToCart(id, finalSpecs, price);
        });
    });
});

function pushToCart(productId, details, productPrice) {
    shoppingCart.push({
        id: productId,
        description: details,
        price: productPrice
    });
    renderCartUI();
}

function renderCartUI() {
    const listWrapper = document.getElementById("cart-items-wrapper");
    const totalSumElement = document.getElementById("cart-total-sum");
    const countBadge = document.getElementById("cart-count");
    
    // Actualizar indicador de cantidad del Header
    countBadge.innerText = shoppingCart.length;
    
    if (shoppingCart.length === 0) {
        listWrapper.innerHTML = '<p class="empty-msg">No has añadido ningún uniforme aún.</p>';
        totalSumElement.innerText = "0.00";
        return;
    }
    
    listWrapper.innerHTML = "";
    let totalCounter = 0;
    
    shoppingCart.forEach((item) => {
        totalCounter += item.price;
        const row = document.createElement("div");
        row.className = "cart-item";
        row.innerHTML = `<span>🐝 ${item.description}</span><strong>$${item.price}.00</strong>`;
        listWrapper.appendChild(row);
    });
    
    totalSumElement.innerText = totalCounter.toFixed(2);
}

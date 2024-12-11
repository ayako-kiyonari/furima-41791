const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; 

  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');
  let errorMessage = document.getElementById('price-error') 

  if (!errorMessage) {
    errorMessage = document.createElement('div');
    errorMessage.id = 'price-error';
    errorMessage.style.color = 'red';
    priceInput.parentNode.appendChild(errorMessage);
  }

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const taxValue = Math.floor(inputValue * 0.1);
    const profitValue = inputValue - taxValue;

    if (/^[0-9]+$/.test(inputValue) && inputValue >= 300 && inputValue <= 9999999) {
      errorMessage.textContent = '';
      addTaxDom.innerHTML = taxValue;
      profitDom.innerHTML = profitValue;
    } else {
      errorMessage.textContent = '';
      addTaxDom.innerHTML = '';
      profitDom.innerHTML = '';
    }
  });
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);
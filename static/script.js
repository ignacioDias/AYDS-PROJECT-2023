const passwordInput = document.getElementById("password");
const passwordRepeatInput = document.getElementById("password_repeat");
const errorBox = document.getElementById("error-box");

function showError(message) {
  errorBox.innerHTML = message;
  errorBox.style.display = "block";
}

function hideError() {
  errorBox.style.display = "none";
}

function validatePassword() {
  if (passwordInput.value !== passwordRepeatInput.value) {
    showError("Las contraseñas no coinciden");
  } else {
    hideError();
  }
}

passwordInput.addEventListener("input", validatePassword);
passwordRepeatInput.addEventListener("input", validatePassword);


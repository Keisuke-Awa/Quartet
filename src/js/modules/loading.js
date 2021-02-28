$("a").onclick = beforeLoad;

for (form in forms) {
  form.onsubmit = beforeLoad;
}

window.onload = completeLoad;

completeLoad;
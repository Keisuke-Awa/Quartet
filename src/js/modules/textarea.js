function flexTextarea(el) {
  const dummy = el.querySelector('.flex-textarea__dummy')
  el.querySelector('.flex-textarea__textarea').addEventListener('input', e => {
    dummy.textContent = e.target.value + '\u200b'
  })
}

document.querySelectorAll('.flex-textarea').forEach(flexTextarea)
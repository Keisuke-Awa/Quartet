"use strict";

$(function() {

  const message_box = document.getElementById('messageBox')

  message_box.scrollTop = message_box.scrollHeight;

  function buildHTML(message) {
    const content = message.content ? `${message.content}` : "";
    const html = `<div class="message" data-id="${message.id}">
                  <div class="message-header">
                    <p class="message-user">
                      ${message.user_name}
                    </p>
                    <p class="message-datetime">
                      ${message.date}
                    </p>
                  </div>
                  <div class="message-body">
                    <p class="message-content">
                      ${message.content}
                    </p>
                  </div>
                </div>`
    return html;
  }

  
  $('#messageForm').submit(function(e){
    const message_form = document.getElementById('messageForm');
    e.preventDefault();
    const message = new FormData(message_form);
    const url = $(message_form).attr('action');

    $.ajax({  
      url: url,
      type: 'POST',
      data: message,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      const html = buildHTML(data);
      console.log(html);
      $('#messageBox').append(html);
      $('#messageText').val("");
      $('#messageBox').animate({ scrollTop: $('#messageBox')[0].scrollHeight});
    })
    .fail(function() {
      alert('メッセージの送信に失敗しました');
    })
    .always(function(data) {
      $('#messageBtn').prop('disabled', false);
    })
  })
});
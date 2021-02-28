"use strict";



$(function() {

  const message_box = document.getElementById('messageBox')

  message_box.scrollTop = message_box.scrollHeight;

  function buildHTML(message) {
    const content = message.content ? `${message.content}` : "";
    let html;
    if (message.is_current_user) {
      html =  `<div class="message message-right" data-message-id="${message.id}">
                <div class="message-body">
                  <br>
                  <div class="message-content">
                    ${content}
                  </div>
                </div>
              </div>`
    } else {
      html =  `<div class="message message-left" data-message-id="${message.id}">
                <div class="message-image">
                  <img class= "rounded-circle" src="${message.user_avatar}">
                </div>
                <div class="message-body">
                  ${message.user_name}
                  <br>
                  <div class="message-content">
                    ${content}
                  </div>
                </div>
              </div>`
    }
    return html;
  }

  
  $('#messageForm').on('submit', function(e){
    e.preventDefault();
    $('#messageBtn').prop('disabled', false);

    if ($('#messageText').val() === "") {
      return false;
    } else {
      const message_form = document.getElementById('messageForm');
      const message = new FormData(message_form);
      const url = $(message_form).attr('action');

      $.ajax({  
        url: url,
        type: 'POST',
        data: message,
        dataType: 'json',
        processData: false,
        contentType: false,
        timeout: 10000
      })
      .done(function(data) {
        const html = buildHTML(data);
        $('#messageBox').append(html);
        $('#messageText').val("");
        $('#messageBox').animate({ scrollTop: $('#messageBox')[0].scrollHeight});
      })
      .fail(function() {
        console.log('メッセージの送信に失敗しました');
      })
      .always(function() {
        $('#messageBtn').prop('disabled', false);
      });
    };
  })

  const reloadMessages = function() {
    const last_message_id = $('.message:last').data("message-id");
    const href = window.location.href + "/messages"
  
    $.ajax ({
      url: href,
      type: 'get',
      dataType: 'json',
      data: {last_id: last_message_id},
      timeout: 10000
    })
    .done(function(messages) {
      let insertHTML = "";
      messages.forEach(function(message) {
        insertHTML = buildHTML(message);
        $('#messageBox').append(insertHTML);
        $('#messageBox').animate({ scrollTop: $('#messageBox')[0].scrollHeight});
      })
    })
    .fail(function () {
      console.log('更新に失敗しました');
    });
  };
  
  setInterval(reloadMessages, 7000);
});
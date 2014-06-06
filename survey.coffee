(($) ->
  $.fn.extend
    survey: ->

      survey = $('<div>', {class: 'survey-wrapper'})
      questionContainer = $('<div>', {class: 'question-container'}).appendTo(survey)
      i = 0
      form = null
      questions = []

      next = ->
        i++
        console.log(i)
        if (i<questions.length)
          display_question()
        else
          submit()

      submit = ->
        setTimeout( ->
          form.submit()
        , 500)

      display_question = () ->
        question = $('<p>', {class: 'question next'})
        question.text(questions[i].text)
        questionContainer.append(question)
        setTimeout(->
          question.removeClass('next').addClass('active')
        , 250)


      up = ->
        $('#'+questions[i].name).attr('checked', true);
        $('.question.active').removeClass('active').addClass('up')
        next()

      down = ->
        $('#'+questions[i].name).attr('checked', false);
        $('.question.active').removeClass('active').addClass('down')
        next()

      return @each () ->
        form = $(this)
        $(this).hide()
        info = $('<div>', {class: 'info'})
        $('<span>', {class: 'key up'}).text('Ja').appendTo(info)
        $('<span>', {class: 'key down'}).text('Nein').appendTo(info)
        info.appendTo(survey)
        for q in $(this).find('label')
          text = $(q).text()
          questions.push({name: $(q).attr('for'), text: text})

        survey.appendTo($('body'))
        display_question()

        $(document).on "keydown", (e) ->
#          if (e.keyCode == 37)  # left
#            next()
#            return false
#
#          if (e.keyCode == 39)  # right
#            next()
#            return false

          if (e.keyCode == 38)  # up
            up()
            return false


          if (e.keyCode == 40)  # down
            down()
            return false
) jQuery
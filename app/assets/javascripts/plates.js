$( document ).ready(function() {

  update_all_boxes();

  $('.plate_horario input.check_boxes').change(function() {
    update_all_boxes();

  });

  function update_all_boxes()
  {
    update_check_boxes($('#plate_horario_1'));
    update_check_boxes($('#plate_horario_2'));
    update_check_boxes($('#plate_horario_4'));
    update_check_boxes($('#plate_horario_8'));
  }

  function update_check_boxes(element) {
    valor = element.val();
    if (valor == "1" || valor == "4")
      {
        if (element.is(':checked'))
        {
          if(valor == "1")
            {
              for (var i =  1; i < 7; i++)
                {
                  $('#plate_tipo_' + i).parent().css('display', 'block');
                }
              }
            else
              {
                for (i =  1; i < 4; i++)
                  {
                    $('#plate_tipo_' + i).parent().css('display', 'block');
                  }
                }
              }
              else
                {
                  if(valor == "1")
                    {
                      for (var i =  1; i < 7; i++)
                        {
                          $('#plate_tipo_' + i).parent().css('display', 'none');
                        }
                      }
                    }
                    return;
                  }

                  if (element.is(':checked')) {
                    for (var i =  7; i < 11; i++) {
                      $('#plate_tipo_' + i).parent().css('display', 'block');
                    }
                  } else {
                    if( $('#plate_horario_2').is(':checked') || $('#plate_horario_8').is(':checked') )
                      return;
                      for (var i =  7; i < 11; i++) {
                        $('#plate_tipo_' + i).parent().css('display', 'none');
                      }
                    }
                  }

                });

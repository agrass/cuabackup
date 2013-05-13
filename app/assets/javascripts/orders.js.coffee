$ ->
	($ 'select#regime_').change ->
		get_plates_from_regime()

	get_plates_from_regime = () ->
		regime_id = ($ 'select#regime_').val()
		horario = ($ '#order_horario').val()
		url = '/get_plates?regime_id='+regime_id+'&horario='+horario
		$.get url, (data) ->
        	$('#plates').html data

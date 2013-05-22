$ ->
	($ 'select#order_patient').change ->
		change_name()

	($ 'select#regime_').change ->
		get_plates_from_regime()

	change_name = (id) ->
		id = ($ 'select#order_patient').val()
		($ 'p#nombre_paciente').html(patient_mapper[id])

	get_plates_from_regime = () ->
		regime_id = ($ 'select#regime_').val()
		horario = ($ '#order_horario').val()
		dia = ($ '#dia_dia').val()
		url = '/get_plates?regime_id='+regime_id+'&horario='+horario+'&dia='+dia
		$.get url, (data) ->
        	$('#plates').html data

$ ->
	$('[data-behaviour~=datepicker]').change ->
		url = $(this).attr('data_url') + '?date=' + $(this).val()
		window.location = url

	($ 'select#order_patient').change ->
		($ '#lista_persona').css("display", "block")
		($ 'input#nombre').attr("checked",true)
		change_name()

	($ 'input#nombre').change ->
		if this.checked
			($ 'input#order_esPaciente').attr("checked",false)
		else
			($ 'input#order_esPaciente').attr("checked",true)

	($ 'input#order_esPaciente').change ->
		if this.checked
			($ 'input#nombre').attr("checked",false)
		else
			($ 'input#nombre').attr("checked",true)

	($ 'select#order_patient').change ->

	change_name = (id) ->
		id = ($ 'select#order_patient').val()
		($ 'label#nombre_paciente').html(patient_mapper[id])

	get_plates_from_regime = () ->
		regime_id = ($ 'select#regime_').val()
		horario = ($ '#order_horario').val()
		dia = ($ '#dia_dia').val()
		url = '/get_plates?regime_id='+regime_id+'&horario='+horario+'&dia='+dia
		$.get url, (data) ->
        	$('#plates').html data

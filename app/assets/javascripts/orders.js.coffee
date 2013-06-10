$ ->
	$('[data-behaviour~=datepicker]').change ->
		url = $(this).attr('data_url') + '?date=' + $(this).val()
		window.location = url

	($ 'select#order_list_patient_id').change ->
		($ '#lista_persona').css("display", "block")
		($ 'input#nombre').attr("checked",true)
		change_name()

	($ 'select#regime_').change ->
		get_plates_from_regime()

	($ 'input#nombre').change ->
		if this.checked
			($ 'input#order_list_esPaciente').attr("checked",false)
		else
			($ 'input#order_list_esPaciente').attr("checked",true)

	($ 'input#order_list_esPaciente').change ->
		if this.checked
			($ 'input#nombre').attr("checked",false)
		else
			($ 'input#nombre').attr("checked",true)

	($ 'select#order_patient').change ->

	change_name = (id) ->
		id = ($ 'select#order_list_patient_id').val()
		($ 'label#nombre_paciente').html(patient_mapper[id])

	get_plates_from_regime = () ->
		regime_id = ($ 'select#regime_').val()
		$('#regime_order_id').attr("value", regime_id)
		horario = ($ '#order_list_orders_attributes_0_horario').val()
		dia = ($ '#dia_dia').val()
		url = '/get_plates?regime_id='+regime_id+'&horario='+horario+'&dia='+dia
		$.get url, (data) ->
        	$('#plates').html data
        	setTimeout(set_images_event, 1000)

	set_images_event = () ->
		$('li.span4').each ->
			$(this).children().last().hide()
			$(this).click ->
				flag = true
				if $(this).children().last().is(':checked')
					flag = false
				$(this).parent().children().each ->
					$(this).removeClass("select")
					$(this).children().last().prop("checked",false)
				if flag
					$(this).addClass("select")
					$(this).children().last().prop("checked", true)

$ ->
	# enable chosen js
	$('.chzn-select').chosen
	    allow_single_deselect: true
	    no_results_text: 'No results matched'
	    width: '200px'

	($ 'select#order_list_patient_id').change ->
		($ '#lista_persona').css("display", "block")
		($ 'input#order_list_esPaciente').attr("checked",true)
		change_name()

	($ 'select#regime_').change ->
		get_plates_from_regime()

	($ 'input#acompanante').change ->
		if this.checked
			($ 'input#order_list_esPaciente').attr("checked",false)
		else
			($ 'input#order_list_esPaciente').attr("checked",true)

	($ 'input#order_list_esPaciente').change ->
		if this.checked
			($ 'input#acompanante').attr("checked",false)
		else
			($ 'input#acompanante').attr("checked",true)

	($ 'select#order_patient').change ->

	change_name = (id) ->
		id = ($ 'select#order_list_patient_id').val()
		($ 'label.boolean').html(patient_mapper[id])

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
		$('li.span2').each ->
			$(this).children().last().hide()
			$(this).find("a").first().popover()
			$(this).children().first().click ->
				flag = true
				if $(this).parent().children().last().is(':checked')
					flag = false
				$(this).parent().parent().children().each ->
					$(this).children().first().removeClass("select")
					$(this).children().last().prop("checked",false)
				if flag
					$(this).addClass("select")
					$(this).parent().children().last().prop("checked", true)

	if $('#regime_order_id').val() != ""
		$('select#regime_').val($('#regime_order_id').val())
		get_plates_from_regime()

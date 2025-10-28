
        $(document).ready(function () {
            $(".cabeza").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
          responsive: true,
            
            sPaginationType: "full_numbers",
			iDisplayLength: 5,
			aLengthMenu: [5,10, 25, 50, 100],
             buttons: [
            {
                extend: 'excelHtml5',
                text: '<i class="fas fa-file-excel"></i> ',
                tittleAttr:  'Exportar a Excel',
                className: 'btn btn-success btn2',
                orientation: 'landscape',
                pageSize: 'LEGAL'
            },
        {
            extend: 'pdfHtml5',
            text: '<i class="fas fa-file-pdf"></i> ',
            tittleAttr:  'Exportar a Pdf',
            orientation: 'landscape',
            className: 'btn btn-danger btn2',
            pageSize: 'LEGAL'            
        },
        {
            extend: 'print',
             text: '<i class="fas fa-print"></i> ',
            tittleAttr:  'Imprimir',
            className: 'btn btn-warning btn2',
           
                   
        },
             ],
			sAjaxDataProp: "waiting",
            autoWidth: false,
            position: 'center',
    dom: 'Blfrtip',
        language: {
            url: "prueba/scripts/datatables/datatables-es.json"
        },  footerCallback: function (tfoot, data, start, end, display) {
      var api = this.api();
      $(tfoot).addClass('fila-suma');
    }
        });
            // Deshabilitar la ordenación y la búsqueda de las celdas con la clase "suma"
            table.columns('.suma').orderable(false).searchable(false);
           
        });

$(document).ready(function() {
    $('#courselist').dataTable( {
      "bStateSave": true,
      "oLanguage" : {
         "sUrl" : "/datatable_i14n"
      },
      "aoColumns" : [
         { "bSortable": false },
         null,
         null,
         {"iDataSort": 4},
         {"bVisible": false}
      ]
    } );
} );

function select_course (entity,domain) {
   $.ajax({
             url: '/entercourse',
             data: { 'entity' : entity, 'domain' : domain },
             type:'POST',
             beforeSend: function() {
                 $.blockUI({
                 message: '<img src="/images/processing.gif" />',
                 css: {
                      border: 'none',
                      padding: '15px',
                      backgroundColor: '#ffffff',
                      'border-radius': '10px',
                      opacity: .5
                      }
                 });
             },
             complete: function () {
                $.unblockUI();
             },
             success: function(response) {
                if (response=='no') {
                   $('.lcstandard').hide();
                   $('.lcerror').hide();
                   $('.lcsuccess').hide();
                   $('.lcproblem').show();
                }
                if (response=='error') {
                   $('.lcstandard').hide();
                   $('.lcproblem').hide();
                   $('.lcsuccess').hide();
                   $('.lcerror').show();
                }
                if (response=='yes') {
                   $('.lcstandard').hide();
                   $('.lcproblem').hide();
                   $('.lcerror').hide();
                   $('.lcsuccess').show();
                   parent.menubar();
                   parent.headermiddle();
                }
             },
             error: function(xhr, ajaxOptions, errorThrown) {
                $.unblockUI;
                $('.lcstandard').hide();
                $('.lcproblem').hide();
                $('.lcsuccess').hide();
                $('.lcerror').show();
             }
         });         
}

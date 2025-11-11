<%@ Page Title="Valoración de Grupos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Valoracion.aspx.cs" Inherits="utc.Valoracion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!--   ESTILOS Y LIBRERÍAS   -->
    <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" />
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

    <style>
      .form-stack{
        max-width: 880px; margin: 20px auto; background:#fff;
        border:1px solid #e5e7eb; border-radius:12px; padding:22px;
        box-shadow:0 2px 8px rgba(0,0,0,.05)
      }
      .form-stack h4{ margin:0 0 12px 0; }
      .form-stack .form-group{ margin-bottom:16px; text-align:left; }
      .form-stack label{ display:block; font-weight:bold; color:#312783; margin-bottom:6px; }
      .form-actions{ display:flex; gap:12px; justify-content:center; flex-wrap:wrap; margin-top:12px; }
      .btn-pill{ border-radius:999px; padding:10px 22px; }
    </style>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <!--   ENCABEZADO PRINCIPAL UTC   -->
    <div class="text-center mb-4">
        <h3 style="color:#312783; font-weight:bold;">
            <i class="fa fa-star"></i> VALORACIÓN DE GRUPOS DE INVESTIGACIÓN
        </h3>

        <asp:LinkButton runat="server" ID="btnRegresarValo" CssClass="btn"
            Style="background:#312783; border-radius:30px; padding:10px 25px; color:white; font-weight:bold;"
            OnClick="btnRegresarValo_Click">
            <i class="fa fa-chevron-left"></i> REGRESAR
        </asp:LinkButton>
    </div>

    <div class="text-center mb-4">
        <asp:LinkButton runat="server" ID="lbtNuevoValo" CssClass="btn"
            Style="background:#312783; border-radius:30px; padding:10px 25px; color:white; font-weight:bold;"
            OnClick="lbtNuevoValo_Click">
            <i class="fa fa-plus"></i> AGREGAR NUEVO
        </asp:LinkButton>
    </div>

    <!--        PANEL DE LA TABLA        -->
    <asp:Panel ID="pnlGrilla" runat="server">
        <br />
        <div class="table table-responsive text-center" style="background-color:#F5F5F5;">
            <asp:GridView runat="server" ID="gvValoracion"
                CssClass="cabeza table table-bordered table-hover table-responsive text-center"
                AutoGenerateColumns="False" GridLines="Horizontal" ShowHeaderWhenEmpty="True"
                EmptyDataText="Sin registros disponibles" ForeColor="#333333">

                <Columns>
                    
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:HiddenField ID="hfRutaInforme" runat="server" Value='<%# Eval("strInforme_valo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="strId_valo" HeaderText="ID" Visible="false" />
                    <asp:BoundField DataField="fkId_gru" HeaderText="GRUPO" />
                    <asp:BoundField DataField="intPuntaje_valo" HeaderText="PUNTAJE" />
                    <asp:BoundField DataField="strCategoria_valo" HeaderText="CATEGORÍA" />
                    <asp:BoundField DataField="dtFecha_valo" HeaderText="FECHA" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="strReconocimiento_valo" HeaderText="RECONOCIMIENTO" />

                    <asp:TemplateField HeaderText="ACCIONES">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnVerArchivoValo" runat="server"
                                CssClass="btn btn-info btn-xs btn-circle"
                                Text="<span class='glyphicon glyphicon-eye-open'></span>"
                                ToolTip="Ver PDF"
                                OnClick="btnVerArchivoValo_Click" />
                            <asp:LinkButton ID="btnBorrarValo" runat="server"
                                CssClass="btn btn-danger btn-xs btn-circle"
                                Text="<span class='glyphicon glyphicon-trash'></span>"
                                ToolTip="Eliminar valoración"
                                OnClientClick="return confirm('¿Desea eliminar esta valoración?');"
                                OnClick="btnBorrarValo_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <AlternatingRowStyle BackColor="White" />
                <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </asp:Panel>

    <!--        PANEL DE AGREGAR         -->
    <asp:Panel ID="pnlAgregarValo" runat="server" Visible="false">
      <div class="form-stack">
        <h4><i class="fa fa-file-circle-plus"></i> Registrar Nueva Valoración</h4>

        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="ddlGrupo" Text="Grupo:" />
          <asp:DropDownList ID="ddlGrupo" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="txtPuntajeValo" Text="Puntaje:" />
          <asp:TextBox ID="txtPuntajeValo" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
        </div>

        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="dtFechaValo" Text="Fecha:" />
          <asp:TextBox ID="dtFechaValo" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
        </div>

        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="txtReconocimiento" Text="Reconocimiento:" />
          <asp:TextBox ID="txtReconocimiento" runat="server" CssClass="form-control"
              TextMode="MultiLine" Rows="4" placeholder="Ej: Reconocimiento, logros, distinciones..."></asp:TextBox>
        </div>

        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="flpArchivoValo" Text="Archivo PDF:" />
          <asp:FileUpload ID="flpArchivoValo" runat="server" CssClass="form-control" />
        </div>

        <div class="form-actions">
          <asp:LinkButton ID="lbtAddValo" runat="server" CssClass="btn btn-success btn-pill"
            OnClick="lbtAddValo_Click" Style="color:white;">
            <i class="fa fa-save"></i> Guardar
          </asp:LinkButton>

          <asp:LinkButton ID="btnRegresarForm" runat="server" CssClass="btn btn-danger btn-pill"
            OnClick="btnRegresarValo_Click" Style="color:white;">
            <i class="fa fa-ban"></i> Cancelar
          </asp:LinkButton>
        </div>
      </div>
    </asp:Panel>

    <!--         SCRIPTS JS            -->
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <script>
        $(document).ready(function () {
            var idTabla = '#<%= gvValoracion.ClientID %>';
            if ($.fn.DataTable.isDataTable(idTabla)) {
                $(idTabla).DataTable().destroy();
            }

            $(idTabla).DataTable({
                language: { url: "//cdn.datatables.net/plug-ins/1.13.7/i18n/es-ES.json" },
                responsive: true,
                dom: 'Bfrtip',
                buttons: [
                    { extend: 'excelHtml5', text: '<i class="fa fa-file-excel"></i> Excel', className: 'btn btn-success btn-sm' },
                    { extend: 'pdfHtml5', text: '<i class="fa fa-file-pdf"></i> PDF', className: 'btn btn-danger btn-sm' },
                    { extend: 'print', text: '<i class="fa fa-print"></i> Imprimir', className: 'btn btn-secondary btn-sm' }
                ]
            });
        });
    </script>

</asp:Content>

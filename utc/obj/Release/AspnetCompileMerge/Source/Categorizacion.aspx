<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorizacion.aspx.cs" Inherits="utc.Categorizacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
       
 <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />

    <script src="prueba/Scripts/datatables/datatables.js"></script>
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>

    <!-- EXPORTAR PDF EXCEL -->
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>

    <script>
    $(document).ready(function () {
        $(".chosen-select").chosen();
    });
</script>


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />

    
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" ></script>

    
 


    <%-- estilos propios para boton redondo--%>
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

    <script type="text/javascript">//para mostrar splash screen
        window.addEventListener('load', function () {
            $(".loading").css("display", "none");
        });

 
    </script>

    <script>
        $(document).ready(function () {
            $('.file-input').fileinput();
        });

    </script>

 


    <%--<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>--%>
    <script src="https://cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>


        <%-- font awesome--%>

      <div class="loading">Loading&#8230;</div>

    <div class="row">
        <div class="col-md-12 text-center">
             
           
            <asp:Panel ID="Panel1" runat="server" BackColor="White" Width="100%">
                <div class="row">
                    <div class="col-md-12 text-center">
                    <div class="col-md-4 text-center">
                        <%--<asp:button Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px; width: 214px; height: 52px;"  BackColor="#312783" ForeColor="White" Font-Bold="True" runat="server" Text="UTC"  ID="btnUtc" ClientIDMode="Static" ToolTip="UNIVERSIDAD TÉCNICA DE COTOPAXI..." Font-Size="25px"> </asp:button>--%>
                       <%-- <label class="" style="color: #312783; font-size:25px;">UTC</label>--%>

                      
                    </div>
                    <div class="col-md-4 text-center">
                        <h3 style="color: #312783; font-weight: bold;"> <i class="fa fa-book"></i> SISTEMA DE GESTIÓN GENERAL DE INVESTIGACIÓN
                        </h3>
                    </div>
                    <div class="col-md-4 text-center">
                        <asp:Linkbutton Cssclass="btn btn btn-bitbucket text-center" CausesValidation="false" style="border-radius: 100px;  width: 260px; height: 47px; font-weight:bold;" runat="server" Text="<span><i class='fa fa-chevron-left'></i></span> REGRESAR" BackColor="#312783" ForeColor="White" Font-Bold="True" ID="btnRegresarCat" ToolTip="REGRESAR..." Font-Size="20px" Visible="false" OnClick="btnRegresarCat_Click"> </asp:Linkbutton>
                        <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>
                        
                        </div>
                    </div>
                </div>
            </asp:Panel>


                <%--    <asp:Button ID="btnCrearCabeceraAcad" runat="server" Text="Nuevo Registo" OnClick="btnCrearCabeceraAcad_Click" CssClass="btn btn-bitbucket " Style="border-radius: 100px;" />--%>
                <asp:Label ID="codigo" runat="server" ForeColor="Red" Visible="false"></asp:Label>
             <br />

            <div class="text-right">
            
            </div>

        </div>
    </div>
       
  <div class="col-md-12 text-center">
         <asp:LinkButton runat="server" ID="lbtNuevoCat" CausesValidation="false" Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px;  width: 260px; height: 47px; font-weight:bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="lbtNuevoCat_Click">Agregar Nuevo</asp:LinkButton>
       <%--  <asp:LinkButton runat="server" ID="lbtPapelera" CausesValidation="false" Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px;  width: 260px; height: 47px; font-weight:bold;" BackColor="#F0AD4E" ForeColor="White" Font-Bold="True" OnClick="lbtPapelera_Click">PAPELERA</asp:LinkButton>
     --%>
      <br />
       <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
      
     <br />
      <br />
      </div>
      
    <asp:Panel runat="server" ID="pnlGrilla">
         
            <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
              
                <asp:GridView runat="server" ID="gvwListadoCat" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                    <Columns>


                        <asp:BoundField DataField="strId_cat" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                      <%--  <asp:BoundField DataField="strArchivo_pro" HeaderText="TEMA PRO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar"  />
                        --%>
                        <asp:BoundField DataField="dtFecha_cat" HeaderText="FECHA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strCategorizacion" HeaderText="CATEGORIZACIÓN" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strApellidos_doc" HeaderText="APELLIDO DOCENTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strNombres_doc" HeaderText="NOMBRE DOCENTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strFuncion_doc" HeaderText="CARGO DOCENTE" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
        
                        <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                            <ItemTemplate>
                                
                                <asp:LinkButton ID="btnEditarCat" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarCat_Click" ToolTip="Editar Registro." Style="color: white;" />
                                <asp:LinkButton ID="btnBorrarCat" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarCat_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                                <%--ELIMINANDO REGISTRO DE LA BDD --%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="White" />

                    <EditRowStyle BackColor="#004289" />
                    <EmptyDataTemplate>
                        SIN REGISTROS
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                    <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />

                    <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                    <SortedAscendingCellStyle BackColor="#004289" />
                    <SortedAscendingHeaderStyle BackColor="#004289" />
                    <SortedDescendingCellStyle BackColor="#004289" />
                    <SortedDescendingHeaderStyle BackColor="#004289" />
                </asp:GridView>
            </div>
    </asp:Panel>

     <asp:Panel runat="server" ID="pnlGrillaDelete">
         
            <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
              
                <asp:GridView runat="server" ID="gvwGrillaDelete" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                    <Columns>


                        <asp:BoundField DataField="strId_cat" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                      <%--  <asp:BoundField DataField="strArchivo_pro" HeaderText="TEMA PRO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar"  />
                        --%>
                        <asp:BoundField DataField="dtFecha_cat" HeaderText="FECHA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strCategorizacion" HeaderText="CATEGORIZACIÓN" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strApellidos_doc" HeaderText="APELLIDO DOC" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strNombres_doc" HeaderText="NOMBRE DOC" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strFuncion_doc" HeaderText="CARGO DOC" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strFechaBorrar_cat" HeaderText="FECHA ELIMINACIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
        
                        <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                            <ItemTemplate>
                                
                                <asp:LinkButton ID="btnEditarCat" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-repeat'></span>" OnClick="btnEditarCat_Click" ToolTip="Recuperar Registro." Style="color: white;" />
                                <asp:LinkButton ID="btnBorrarCatDef" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarCatDef_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                                <%--ELIMINANDO REGISTRO DE LA BDD --%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="White" />

                    <EditRowStyle BackColor="#004289" />
                    <EmptyDataTemplate>
                        SIN REGISTROS
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                    <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />

                    <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                    <SortedAscendingCellStyle BackColor="#004289" />
                    <SortedAscendingHeaderStyle BackColor="#004289" />
                    <SortedDescendingCellStyle BackColor="#004289" />
                    <SortedDescendingHeaderStyle BackColor="#004289" />
                </asp:GridView>
            </div>
    </asp:Panel>

    <asp:Panel ID="pnlAgregrarCat" runat="server" Visible="false">
    <div class="row">
        <div class="col-md-12 text-center form-control">
            Agregando Nueva Categorización...
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione el docente</asp:Label>
                <asp:DropDownListChosen ID="ddlDocente" runat="server"
                    CssClass="chosen-select form-control"
                    NoResultsText="No se encontraron resultados..."
                    DataPlaceHolder="Escriba aquí..."
                    BackColor="#F0AD4E"
                    ForeColor="White"
                    
                    AllowSingleDeselect="false"
                  >
                </asp:DropDownListChosen>
              
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la fecha</asp:Label>
                <asp:TextBox ID="txtFechaCat" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="txtFechaCat"
                    ErrorMessage="Seleccione una fecha" ForeColor="Red" Display="Dynamic" />
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la Categoría</asp:Label>
                <asp:DropDownList ID="ddlCat" CssClass="form-control text-center" runat="server"
                    Width="100%" BackColor="#F0AD4E" ForeColor="White">
                    <asp:ListItem Value="AUXILIAR 1">AUXILIAR 1</asp:ListItem>
                    <asp:ListItem Value="AUXILIAR 2">AUXILIAR 2</asp:ListItem>
                    <asp:ListItem Value="AUXILIAR 3">AUXILIAR 3</asp:ListItem>
                    <asp:ListItem Value="AGREGADO 1">AGREGADO 1</asp:ListItem>
                    <asp:ListItem Value="AGREGADO 2">AGREGADO 2</asp:ListItem>
                    <asp:ListItem Value="AGREGADO 3">AGREGADO 3</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 1">PRINCIPAL 1</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 2">PRINCIPAL 2</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 3">PRINCIPAL 3</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 4">PRINCIPAL 4</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategoria" runat="server" ControlToValidate="ddlCat"
                    ErrorMessage="Seleccione una categoría" ForeColor="Red" Display="Dynamic" />
            </div>
        </div>
        <div class="col-md-12 text-center">
            <br />
            <asp:LinkButton ID="lbtADDCat" runat="server" CssClass="btn btn-success" OnClick="lbtADDCat_Click"
                Style="border-radius: 100px; color: white;">
                <span class="glyphicon glyphicon-floppy-disk"></span> CREAR REGISTRO
            </asp:LinkButton>
            <asp:LinkButton ID="lbtCancelarCat" CausesValidation="false" runat="server" CssClass="btn btn-danger"
                Style="border-radius: 100px; color: white;" Text="<span class='glyphicon glyphicon-ban-circle'></span> CANCELAR REGISTRO"
                OnClick="lbtCancelarCat_Click" />
            <br />
            <br />
        </div>
    </div>
</asp:Panel>

       <asp:Panel ID="pnlEditarCat" runat="server" Visible="false">
    <div class="row">
        <div class="col-md-12 text-center form-control">
            Editando Categorización...
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione el docente</asp:Label>
                <asp:DropDownListChosen ID="ddlEditDocente" runat="server" Enabled="false"
                    CssClass="chosen-select form-control"
                    NoResultsText="No se encontraron resultados..."
                    DataPlaceHolder="Escriba aquí..."
                    BackColor="#F0AD4E"
                    ForeColor="White"
                    AllowSingleDeselect="true"
                    AutoPostBack="true">
                </asp:DropDownListChosen>
                <asp:RequiredFieldValidator ID="rfvEditDoc" runat="server" ControlToValidate="ddlEditDocente"
                    ErrorMessage="Seleccione un docente" ForeColor="Red" Display="Dynamic" />
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la fecha</asp:Label>
                <asp:TextBox ID="txtEditFechaCat" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                <asp:RequiredFieldValidator ID="tfvFechaEditCat" runat="server" ControlToValidate="txtEditFechaCat"
                    ErrorMessage="Seleccione una fecha" ForeColor="Red" Display="Dynamic" />
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la Categoría</asp:Label>
                <asp:DropDownList ID="ddlEditCat" CssClass="form-control text-center" runat="server"
                    Width="100%" BackColor="#F0AD4E" ForeColor="White">
                    <asp:ListItem Value="AUXILIAR 1">AUXILIAR 1</asp:ListItem>
                    <asp:ListItem Value="AUXILIAR 2">AUXILIAR 2</asp:ListItem>
                    <asp:ListItem Value="AUXILIAR 3">AUXILIAR 3</asp:ListItem>
                    <asp:ListItem Value="AGREGADO 1">AGREGADO 1</asp:ListItem>
                    <asp:ListItem Value="AGREGADO 2">AGREGADO 2</asp:ListItem>
                    <asp:ListItem Value="AGREGADO 3">AGREGADO 3</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 1">PRINCIPAL 1</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 2">PRINCIPAL 2</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 3">PRINCIPAL 3</asp:ListItem>
                    <asp:ListItem Value="PRINCIPAL 4">PRINCIPAL 4</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCatEdit" runat="server" ControlToValidate="ddlEditCat"
                    ErrorMessage="Seleccione una categoría" ForeColor="Red" Display="Dynamic" />
            </div>
        </div>
        <div class="col-md-12 text-center">
            <br />
            <asp:LinkButton ID="lbtnEditCat" runat="server" CssClass="btn btn-success" OnClick="lbtnEditCat_Click"
                Style="border-radius: 100px; color: white;">
                <span class="glyphicon glyphicon-floppy-disk"></span> EDITAR REGISTRO
            </asp:LinkButton>
            <asp:LinkButton ID="lbtnCancellEditCat" CausesValidation="false" runat="server" CssClass="btn btn-danger"
                Style="border-radius: 100px; color: white;" Text="<span class='glyphicon glyphicon-ban-circle'></span> CANCELAR EDICIÓN"
                OnClick="lbtnCancellEditCat_Click" />
            <br />
            <br />
        </div>
    </div>
</asp:Panel>


</asp:Content>

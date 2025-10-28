<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="error.aspx.cs" Inherits="publico_error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../../Styles/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" />
      <%-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"/>--%>
    
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="alert alert-info alert-dismissible">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <asp:Label ID="lblMsg" ForeColor="Red" Font-Bold="true" Font-Size="Larger" Text=".." runat="server"></asp:Label>

    </div>
    <div style="text-align:center" >
    <asp:LinkButton ID="lnkbLogin" CssClass="btn btn-block" runat="server" OnClick="lnkbLogin_Click">Ingresar nuevamente al sistema!</asp:LinkButton>
        </div>
</asp:Content>


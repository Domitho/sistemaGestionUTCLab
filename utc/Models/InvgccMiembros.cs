using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace utc.Models
{
    public class InvgccMiembros
    {
        // Campos de la tabla INVGCCMIEMBROS
        [JsonProperty("strId_mie")]
        public string StrIdMie1 { get; set; }

        [JsonProperty("strFuncion_mie")]
        public string StrFuncionMie { get; set; }

        [JsonProperty("fkId_cen")]
        public string fkId_cen { get; set; }
        [JsonProperty("fkIdGru")]
        public string fkIdGru { get; set; }

        [JsonProperty("dtFechaini_mie")]
        public DateTime DtFechaIniMie { get; set; }

        [JsonProperty("dtFechafin")]
        public DateTime DtFechaFin { get; set; }

        // Campos de la tabla INVGCCGRUPO_INVESTIGACION
        [JsonProperty("strId_gru")]
        public string StrIdGru { get; set; }

        [JsonProperty("strNombre_gru")]
        public string StrNombreGru { get; set; }

        [JsonProperty("strCoordinador_gru")]
        public string StrCoordinadorGru { get; set; }

    

        // Campos de la tabla INVGCCCENTRO_INESTIGACION
        [JsonProperty("strId_cen")]
        public string StrIdCen { get; set; }

        [JsonProperty("strNombre_cen")]
        public string StrNombreCen { get; set; }

        [JsonProperty("strDescripcion_cen")]
        public string StrDescripcionCen { get; set; }

        [JsonProperty("strObservacion_cen")]
        public string StrObservacionCen { get; set; }
    }
}
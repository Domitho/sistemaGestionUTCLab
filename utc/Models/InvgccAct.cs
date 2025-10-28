using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using System.Web;

namespace utc.Models
{
    public class InvgccAct
    {
        [JsonProperty("strId_act")]
        public string strId_act { get; set; }

        [JsonProperty("decPrecio_pro2")]
        public float decPrecio_pro2 { get; set; }
        
        [JsonProperty("strInsumos_pro")]
        public string strInsumos_pro { get; set; }

        [JsonProperty("strNombre_act")]
        public string strNombre_act { get; set; }

        [JsonProperty("strDescripcion_act")]
        public string strDescripcion_act { get; set; }

        [JsonProperty("dtFechaini_act")]
        public DateTime dtFechaini_act { get; set; }

        [JsonProperty("dtFechafinal_act")]
        public DateTime dtFechafinal_act { get; set; }

        [JsonProperty("decCosto_act")]
        public float decCosto_act { get; set; }

        [JsonProperty("strArchivo_act")]
        public string strArchivo_act { get; set; }

        [JsonProperty("strEstado_act")]
        public string strEstado_act { get; set; }

        [JsonProperty("decValortotal_act")]
        public float decValortotal_act { get; set; }

        [JsonProperty("fkId_pro")]
        public string fkId_pro { get; set; }

    }
}
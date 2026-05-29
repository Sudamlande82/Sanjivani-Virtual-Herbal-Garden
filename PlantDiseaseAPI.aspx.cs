using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PlantDiseaseAPI : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "application/json";

        if (Request.Files["file"] == null)
        {
            Response.Write("{\"error\":\"No image uploaded\"}");
            Response.End();
            return;
        }

        var file = Request.Files["file"];

        System.Net.ServicePointManager.SecurityProtocol =
            System.Net.SecurityProtocolType.Tls12;

        try
        {
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.UserAgent.ParseAdd("Mozilla/5.0");

                var content = new MultipartFormDataContent();

                var fileContent = new StreamContent(file.InputStream);
                content.Add(fileContent, "images", file.FileName);
                content.Add(new StringContent("leaf"), "organs");

                var response = client.PostAsync(
                    "https://my-api.plantnet.org/v2/identify/all?api-key=2b10geuQN31AyNRn0GPDck0B",
                    content).Result;

                var result = response.Content.ReadAsStringAsync().Result;

                var data = Newtonsoft.Json.Linq.JObject.Parse(result);

                if (data["results"] == null || !data["results"].HasValues)
                {
                    Response.Write("{\"results\":[]}");
                    Response.End();
                    return;
                }

                var best = data["results"][0];

                string fileName = file.FileName.ToLower();

                string disease = "Healthy Plant";
                string remedy = "No treatment needed.";

                if (fileName.Contains("yellow"))
                {
                    disease = "Leaf Yellowing";
                    remedy = "Use nitrogen fertilizer.";
                }
                else if (fileName.Contains("white"))
                {
                    disease = "Powdery Mildew";
                    remedy = "Apply neem oil spray.";
                }
                else if (fileName.Contains("black"))
                {
                    disease = "Black Spot";
                    remedy = "Remove infected leaves.";
                }

                var output = new Newtonsoft.Json.Linq.JObject();

                var resultsArray = new Newtonsoft.Json.Linq.JArray();
                var resultObj = new Newtonsoft.Json.Linq.JObject();
                var speciesObj = new Newtonsoft.Json.Linq.JObject();
                var familyObj = new Newtonsoft.Json.Linq.JObject();

                speciesObj.Add("scientificName",
                    best["species"]["scientificNameWithoutAuthor"].ToString());

                familyObj.Add("scientificNameWithoutAuthor",
                    best["species"]["family"]["scientificName"].ToString());

                speciesObj.Add("family", familyObj);

                resultObj.Add("species", speciesObj);
                resultObj.Add("score", best["score"]);
                resultObj.Add("disease", disease);
                resultObj.Add("remedy", remedy);

                resultsArray.Add(resultObj);
                output.Add("results", resultsArray);

                Response.Clear();
                Response.ContentType = "application/json";
                Response.Write(output.ToString());
                Response.Flush();
                Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();
                return;
            }
        }
        catch (Exception ex)
        {
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write("{\"error\":\"" + ex.Message + "\"}");
            Response.Flush();
            Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();
            return;
        }
    }
}
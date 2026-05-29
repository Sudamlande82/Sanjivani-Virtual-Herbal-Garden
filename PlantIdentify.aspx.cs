using Newtonsoft.Json;
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

public partial class PlantIdentify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected async void btnIdentify_Click(object sender, EventArgs e)
    {
        if (!FileUpload1.HasFile)
        {
            plantTitle.InnerText = "Upload image first";
            resultCard.Style["display"] = "block";
            return;
        }

        // TLS fix
        System.Net.ServicePointManager.SecurityProtocol =
            System.Net.SecurityProtocolType.Tls12;

        try
        {
            using (var client = new HttpClient())
            {
                // Some APIs reject requests without a User-Agent
                client.DefaultRequestHeaders.UserAgent.ParseAdd("Mozilla/5.0");

                var content = new MultipartFormDataContent();

                // 🔥 IMPORTANT: correct field name = "images"
                var fileContent = new StreamContent(FileUpload1.FileContent);
                fileContent.Headers.ContentType =
                    new System.Net.Http.Headers.MediaTypeHeaderValue("image/jpeg");

                content.Add(fileContent, "images", FileUpload1.FileName);

                // 🔥 IMPORTANT: organ
                content.Add(new StringContent("leaf"), "organs");

                var url = "https://my-api.plantnet.org/v2/identify/all?api-key=2b10geuQN31AyNRn0GPDck0B&lang=en";

                var response = await client.PostAsync(url, content);

                var result = await response.Content.ReadAsStringAsync();

                // 🔍 Debug (very important)
                System.Diagnostics.Debug.WriteLine(result);

                if (!response.IsSuccessStatusCode)
                {
                    plantTitle.InnerText = "API Error: " + response.StatusCode;
                    plantTag.InnerText = result; // shows exact API message
                    resultCard.Style["display"] = "block";
                    return;
                }

                // Parse JSON
                var data = Newtonsoft.Json.Linq.JObject.Parse(result);

                if (data["results"] != null && data["results"].HasValues)
                {
                    var best = data["results"][0];

                    plantTitle.InnerText =
                        best["species"]["scientificNameWithoutAuthor"].ToString();

                    plantTag.InnerText =
                        "Confidence: " +
                        (double.Parse(best["score"].ToString()) * 100).ToString("0.00") + "%";

                    plantFamily.InnerText =
                        "Family: " +
                        best["species"]["family"]["scientificName"].ToString();
                }
                else
                {
                    plantTitle.InnerText = "Plant not identified";
                    plantTag.InnerText = "Try clearer leaf image";
                    plantFamily.InnerText = "";
                }

                resultCard.Style["display"] = "block";
            }
        }
        catch (Exception ex)
        {
            plantTitle.InnerText = "Error: " + ex.Message;
            resultCard.Style["display"] = "block";
        }
    }
}
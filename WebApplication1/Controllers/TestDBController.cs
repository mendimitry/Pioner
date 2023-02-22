using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.EntityFrameworkCore;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TestDBController : Controller
    {
        MaindataContext db;

        private readonly ILogger<TestDBController> _logger;

        public TestDBController(ILogger<TestDBController> logger)
        {
            _logger = logger;
        }

       // [HttpGet(Name = "GetTest")]
       // public IEnumerable<Test> Get()
       // {
       //     db = new MaindataContext();
       //     return db.Tests.ToList();
       // }

       [HttpGet(Name = "GetTest")]
        public async Task<JsonResult> Get(string? phoneNumber)
        {
            db = new MaindataContext();
            var jsonOptions = new System.Text.Json.JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true, // учитываем регистр
                WriteIndented = true                // отступы для красоты
            };

            Test? test = await db.Tests.FirstOrDefaultAsync(t => t.PhoneNumber == phoneNumber);
            if (test == null)
            {
                Test newTest = new Test();
                newTest.PhoneNumber = phoneNumber;
                newTest.DateTime = DateTime.Now.ToString();

                db.Tests.Add(newTest);
                await db.SaveChangesAsync();
                return Json(newTest, jsonOptions);
            }
            else
            {
                return Json(test, jsonOptions);
            }
        }
    }
}
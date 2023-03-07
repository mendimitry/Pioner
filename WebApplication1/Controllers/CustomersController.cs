using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomersController : ControllerBase
    {
        MaindataContext db;

        // GET: api/Customers
        [HttpGet]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public async Task<ActionResult<IEnumerable<Customer>>> GetCustomers()
        {
            db = new MaindataContext();
            return await db.Customers.ToListAsync();
        }

        // GET: api/Customers/number/89123456210
        [HttpGet("number/{CustomerPhoneNumber}")]
        public async Task<ActionResult<Customer>> GetCustomerByPhone(string CustomerPhoneNumber)
        {
            db = new MaindataContext();
            var customer = await db.Customers.FirstOrDefaultAsync(t => t.CustomerPhoneNumber == CustomerPhoneNumber);

            if (customer == null)
            {
                return NotFound();
            }

            return customer;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Customer>> GetCustomer(long id)
        {
            db = new MaindataContext();
            var customer = await db.Customers.FindAsync(id);

            if (customer == null)
            {
                return NotFound();
            }

            return customer;
        }

        // PUT: api/Customers/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        /*[HttpPut("{id}")]
         public async Task<IActionResult> PutCustomer(long id, Customer customer)
         {
             if (id != customer.CustomerId)
             {
                 return BadRequest();
             }

             _context.Entry(customer).State = EntityState.Modified;

             try
             {
                 await _context.SaveChangesAsync();
             }
             catch (DbUpdateConcurrencyException)
             {
                 if (!CustomerExists(id))
                 {
                     return NotFound();
                 }
                 else
                 {
                     throw;
                 }
             }

             return NoContent();
         }
        */
        // POST: api/Customers
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Customer>> PostCustomer(Customer customer)
        {
            db = new MaindataContext();
            db.Customers.Add(customer);
            await db.SaveChangesAsync();

            return CreatedAtAction("GetCustomer", new { id = customer.CustomerId }, customer);
        }

        [HttpPost("login/{phoneNumber}")]
        public async Task<ActionResult> LoginCustomer(string phoneNumber)
        {
            db = new MaindataContext();
            if (CustomerExists(phoneNumber) == true)
            {
                Customer loggedInUser = await db.Customers.FirstOrDefaultAsync(c => c.CustomerPhoneNumber == phoneNumber);
                var claims = new[]
                {
                    new Claim(ClaimTypes.NameIdentifier,loggedInUser.CustomerPhoneNumber),
                    new Claim(ClaimTypes.Name,loggedInUser.CustomerName),
                    new Claim(ClaimTypes.Surname,loggedInUser.CustomerSurname),
                };

                var token = new JwtSecurityToken
                (
                    issuer: "https://localhost:7115/",
                    audience: "Pioneer",
                    claims: claims,
                    expires: DateTime.UtcNow.AddDays(60),
                    notBefore: DateTime.UtcNow,
                    signingCredentials: new SigningCredentials(new SymmetricSecurityKey(Encoding.UTF8.GetBytes("12345678912345678912345678912345678AbObA")), SecurityAlgorithms.HmacSha256)
                );
                var tokenString = new JwtSecurityTokenHandler().WriteToken(token);
                return Ok(tokenString);
            }

            return NotFound("Такой пользователь не существует");
        }
        /*
        // DELETE: api/Customers/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomer(long id)
        {
            var customer = await _context.Customers.FindAsync(id);
            if (customer == null)
            {
                return NotFound();
            }

            _context.Customers.Remove(customer);
            await _context.SaveChangesAsync();

            return NoContent();
        }
       */
        private bool CustomerExists(string CustomerPhoneNumber)
        {
            db = new MaindataContext();
            return db.Customers.Any(e => e.CustomerPhoneNumber == CustomerPhoneNumber);
        }
    }
}

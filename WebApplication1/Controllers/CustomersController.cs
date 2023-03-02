using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
        public async Task<ActionResult<IEnumerable<Customer>>> GetCustomers()
        {
            db = new MaindataContext();
            return await db.Customers.ToListAsync();
        }

        // GET: api/Customers/Number/89123456210
        [HttpGet("Number/{CustomerPhoneNumber}")]
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
            //Customer customer = new Customer();
            //customer.CustomerName = CustomerName;
            //customer.CustomerPhoneNumber = CustomerPhoneNumber;
            //customer.CustomerSurname = CustomerSurname;
            db.Customers.Add(customer);
            await db.SaveChangesAsync();

            return CreatedAtAction("GetCustomer", new { id = customer.CustomerId }, customer);
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

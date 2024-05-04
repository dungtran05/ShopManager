using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using backendshop.Data;
using backendshop.Models;
using backendshop.DTO;

namespace backendshop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly backendshopContext _context;

        public UsersController(backendshopContext context)
        {
            _context = context;
        }

        // GET: api/Users
        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUser()
        {
            return await _context.User.ToListAsync();
        }

        // GET: api/Users/5
        [HttpGet("{id}")]
        public async Task<ActionResult<User>> GetUser(int id)
        {
            var user = await _context.User.FindAsync(id);

            if (user == null)
            {
                return NotFound();
            }

            return user;
        }

        // PUT: api/Users/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUser(int id, User user)
        {
            if (id != user.ID)
            {
                return BadRequest();
            }

            _context.Entry(user).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(id))
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

        // POST: api/Users
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<User>> PostUser(User user)
        {
            _context.User.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUser", new { id = user.ID }, user);
        }

        // DELETE: api/Users/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await _context.User.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            _context.User.Remove(user);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserExists(int id)
        {
            return _context.User.Any(e => e.ID == id);
        }

        [HttpGet("{UserName}/{Password}")]
        public async Task<ActionResult<User>> Login(string UserName, string Password)
        {
            var user = await _context!.User.SingleOrDefaultAsync(p => p.UserName == UserName && p.Password == Password);
            if (user == null)
            {
                return new User();
            }
            else
            {
                return user;
            }
        }

        [HttpGet("/{imageurl}")]
        public IActionResult GetImage(string imageurl)
        {
            // Đường dẫn tương đối từ thư mục gốc của ứng dụng đến thư mục "assets"
            var assetsPath = Path.Combine(Directory.GetCurrentDirectory(), "assets");
            var imagePath = Path.Combine(assetsPath, imageurl.ToString());

            if (!System.IO.File.Exists(imagePath))
            {
                return NotFound();
            }

            var imageBytes = System.IO.File.ReadAllBytes(imagePath);
            return File(imageBytes, "image/jpeg");
        }
        [HttpGet("/getallcart/{userid}")]
        public async Task<ActionResult<IEnumerable<Cart>>> GetAllCart(int userid)
        {
            var cart = await _context.Cart
                .Where(c => c.UserId == userid)
                .Include(p => p.Product)
                .ToListAsync();
            if (cart == null)
            {
                return NotFound();
            }
            else
            {
                return cart;
            }

        }
        [HttpPost("/addcarttouser")]
        public async Task<ActionResult<Cart>> AddCartToUser(CartDTO cartDTO)
        {
            var cart = new Cart
            {
                UserId = cartDTO.userId,
                ProductId = cartDTO.productId,
                quantity = cartDTO.quantity
            };

            _context.Cart.Add(cart);
            await _context.SaveChangesAsync();
            return Ok(cart);
        }
        [HttpDelete("/{cartId}/{userid}")]
        public async Task<ActionResult<List<Cart>>> RemoveCart(int cartId, int userid)
        {
            try
            {
                var cartToRemove = await _context.Cart.FindAsync(cartId);



                _context.Cart.Remove(cartToRemove);
                await _context.SaveChangesAsync();

                return await _context.Cart
                .Where(c => c.UserId == userid)
                .Include(p => p.Product)
                .ToListAsync();
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
        [HttpPut("increasecart")]
        public async Task<ActionResult<List<Cart>>> IncreaseCart(int cartid, int userid)
        {
            var cart = await _context.Cart.FirstOrDefaultAsync(c => c.Id == cartid);
            if (cart == null)
            {
                return NotFound();
            }
            else
            {
                cart.quantity += 1;
            }
            await _context.SaveChangesAsync();
            return await _context.Cart
                .Where(c => c.UserId == userid)
                .Include(p => p.Product)
                .ToListAsync();

        }
        [HttpPut("decreasecart")]
        public async Task<ActionResult<List<Cart>>> DecreaseCart(int cartid, int userid)
        {
            var cart = await _context.Cart.FirstOrDefaultAsync(c => c.Id == cartid);
            if (cart == null)
            {
                return NotFound();
            }
            else
            {
                if (cart.quantity > 1)
                {
                    cart.quantity -= 1;
                }
                else
                {
                    _context.Cart.Remove(cart);
                }
            }
            await _context.SaveChangesAsync();
            return await _context.Cart
                .Where(c => c.UserId == userid)
                .Include(p => p.Product)
                .ToListAsync();

        }
        [HttpPost("/SignUp")]
        public async Task<ActionResult<User>> SignUp(UserDTO userDTO)
        {
            var user = new User {
                FirstName=userDTO.FirstName,
                LastName=userDTO.LastName,
                UserName=userDTO.UserName,
                Password=userDTO.Password
            
            };
            _context.User.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUser", new { id = user.ID }, user);
        }




    }
}

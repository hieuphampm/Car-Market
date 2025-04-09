using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Objects;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CarImagesController : ControllerBase
    {
        private readonly CarMarketDbContext _context = new CarMarketDbContext();

        //public CarImagesController(CarMarketDbContext context)
        //{
        //    _context = context;
        //}

        // GET: api/CarImages
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CarImage>>> GetCarImages()
        {
            return await _context.CarImages.ToListAsync();
        }

        // GET: api/CarImages/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CarImage>> GetCarImage(int id)
        {
            var carImage = await _context.CarImages.FindAsync(id);

            if (carImage == null)
            {
                return NotFound();
            }

            return carImage;
        }

        // PUT: api/CarImages/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCarImage(int id, CarImage carImage)
        {
            if (id != carImage.ImageId)
            {
                return BadRequest();
            }

            _context.Entry(carImage).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CarImageExists(id))
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

        // POST: api/CarImages
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CarImage>> PostCarImage(CarImage carImage)
        {
            _context.CarImages.Add(carImage);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCarImage", new { id = carImage.ImageId }, carImage);
        }

        // DELETE: api/CarImages/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCarImage(int id)
        {
            var carImage = await _context.CarImages.FindAsync(id);
            if (carImage == null)
            {
                return NotFound();
            }

            _context.CarImages.Remove(carImage);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CarImageExists(int id)
        {
            return _context.CarImages.Any(e => e.ImageId == id);
        }
    }
}

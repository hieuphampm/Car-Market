using CarMarketAPI.Data;
using CarMarketAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CarMarketAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CarModelsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public CarModelsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/CarModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CarModel>>> GetCarModels()
        {
            return await _context.CarModels
                .Include(cm => cm.Manufacturer)
                .ToListAsync();
        }

        // GET: api/CarModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CarModel>> GetCarModel(int id)
        {
            var carModel = await _context.CarModels
                .Include(cm => cm.Manufacturer)
                .FirstOrDefaultAsync(cm => cm.ModelID == id);

            if (carModel == null)
            {
                return NotFound();
            }

            return carModel;
        }

        // POST: api/CarModels
        [HttpPost]
        public async Task<ActionResult<CarModel>> PostCarModel(CarModel carModel)
        {
            _context.CarModels.Add(carModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCarModel), new { id = carModel.ModelID }, carModel);
        }

        // PUT: api/CarModels/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCarModel(int id, CarModel carModel)
        {
            if (id != carModel.ModelID)
            {
                return BadRequest();
            }

            carModel.DateModified = DateTime.Now;
            _context.Entry(carModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CarModelExists(id))
                {
                    return NotFound();
                }
                throw;
            }

            return NoContent();
        }

        // DELETE: api/CarModels/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCarModel(int id)
        {
            var carModel = await _context.CarModels.FindAsync(id);
            if (carModel == null)
            {
                return NotFound();
            }

            _context.CarModels.Remove(carModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CarModelExists(int id)
        {
            return _context.CarModels.Any(e => e.ModelID == id);
        }
    }
}
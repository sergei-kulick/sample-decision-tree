using Microsoft.AspNetCore.Mvc;

namespace sample_decision_tree.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DecisionTree : ControllerBase
    {
        private readonly ILogger<DecisionTree> _logger;

        public DecisionTree(ILogger<DecisionTree> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public async Task<IEnumerable<Model>> Get([FromQuery(Name = "id")] int id)
        {
            var repo = new DecisionTreeRepo();
            return await repo.GetComponents(id);
        }
    }
}
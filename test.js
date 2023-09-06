const chai = require('chai');
const chaiHttp = require('chai-http');
const {app} = require('./main');

chai.use(chaiHttp);
const expect = chai.expect;

describe('Health Check Endpoint', () => {
  let server;

  before((done) => {
    server = app.listen(0, () => {
      done();
    });
  });

  it('should return "OK" when accessing /health', (done) => {
    chai
        .request(server) // Gunakan server yang telah dibuat
        .get('/health')
        .end((err, res) => {
          expect(res).to.have.status(200);
          expect(res.text).to.equal('OK');
          done(); // Panggil done() ketika pengujian selesai
        });
  });
});

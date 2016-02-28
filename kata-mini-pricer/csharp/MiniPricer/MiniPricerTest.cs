using System;
using NUnit.Framework;

namespace MiniPricer
{
    class MiniPricerTest
    {
        private static readonly DateTime Tuesday = new DateTime(2015, 4, 7);
        private static readonly DateTime Wednesday = new DateTime(2015, 4, 8);
        private static readonly DateTime Friday = new DateTime(2015, 4, 10);
        private static readonly DateTime Monday = new DateTime(2015, 4, 13);

        private const double InitialPrice = 100d;
        private const double Volatility = 10d;

        [Test]
        public void Price_at_one_day ()
        {
            var pricer = new Pricer(Tuesday);
            var priceAt1Day = pricer.Price(Wednesday, InitialPrice, Volatility);            
            Assert.AreEqual(110d, priceAt1Day, 0.001);
        }

        [Test]
        public void Price_at_3_days()
        {
            var pricer = new Pricer(Tuesday);
            var priceAt3Days = pricer.Price(Friday, InitialPrice, Volatility);
            Assert.AreEqual(133.1d, priceAt3Days, 0.001);
        }

        [Test]
        public void Price_over_week_end()
        {
            var pricer = new Pricer(Friday);

            var priceOverWeekEnd = pricer.Price(Monday, InitialPrice, Volatility);
            Assert.AreEqual(110d, priceOverWeekEnd, 0.001);
        }

        [Test]
        public void Price_over_bank_holliday()
        {
            var pricer = new Pricer(Friday);

            var priceOverWeekEnd = pricer.Price(Monday, InitialPrice, Volatility);
            Assert.AreEqual(110d, priceOverWeekEnd, 0.001);
        }


    }
}

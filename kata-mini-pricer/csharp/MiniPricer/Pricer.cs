using System;

namespace MiniPricer
{
    public class Pricer
    {
        private readonly DateTime _startDate;

        public Pricer(DateTime startDate)
        {
            _startDate = startDate;
        }

        public double Price(DateTime priceDate, double initialPrice, double volatility)
        {
            return PriceFromTo(_startDate, priceDate, initialPrice, volatility);
        }

        private double PriceFromTo(DateTime startDate, DateTime endDate, double initialPrice, double volatility)
        {
            if (startDate == endDate) return initialPrice;
          
            return PriceFromTo(NextOpenDayAfter(startDate), endDate, initialPrice, volatility) * (1 + volatility / 100d);            
        }

        private DateTime NextOpenDayAfter(DateTime d)
        {
            if (d.DayOfWeek == DayOfWeek.Friday) return d.AddDays(3);
            if (d.DayOfWeek == DayOfWeek.Saturday) return d.AddDays(2);
            return d.AddDays(1);
        }
    }
}
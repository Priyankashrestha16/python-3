import random
from errorhandling import DepositAmountError, WithdrawAmountError, AccountNumberError

class Bank:
    def __init__(self,name, initial_balance,job,phone):
        self.name=name
        self.initial_balance=initial_balance
        self.job=job
        self.phone=phone
        self.account_number=self.name[1:3]+"".join(str(random.randint(0,9)) for i in range(16))+ 'NB'

    #Deposit Amount
    def deposit_amount(self,amount):
        if amount>=100:
            self.initial_balance+=amount
            print(f'Rs {amount} has been deposited to {self.account_number}')
        else:
            raise  DepositAmountError('Deposit amount must be more than Rs.100.')

    #Withdrawn Amount
    def withdrawamount(self,amount):
        if amount<self.initial_balance:
            if amount >=100:
                self.initial_balance -=amount
                print(f'Rs {amount} has been withdrawn from A/C no. {self.account_number}')
            else:
                print('Withdraw amount must be more than Rs.100.')
        else:
            raise WithdrawAmountError('withdrawn amount must be less than initial balance.')

    #show user details
    def userdetails(self):
        print(f'Account Name: {self.name}')
        print(f'Account Number: {self.account_number}')
        print(f'Initial Balance:Rs{self.initial_balance}')
        print(f'Phone Number: {self.phone}')
        print(f'Job Position: {self.job}')
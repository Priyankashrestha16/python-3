
from errorhandling import DepositAmountError, WithdrawAmountError,AccountNumberError
from storage import all_accounts
from bank import Bank
from functions import findAccount

def bankApp():
    while True:
        print('Welcome to Bank Application')
        print('1.Create Account')
        print('2.Deposit Account')
        print('3.WIthdraw Account')
        print('4.User Details')
        print('5.Exit')
        print('\n')

        choice=int(input('Enter your choice: '))
        if choice==1:
            yes_no=input('Do you want to create account? (yes/no)')
            if yes_no=='yes':
            
                print('Create Account')
                name=input("Enter your name: ")
                initial_balance=float(input('enter your balance: '))
                job=input('enter your job: ')
                phone=int(input('enter your phone number:'))
                if initial_balance>=100:
                    b=Bank(name,initial_balance,job,phone)
                    all_accounts.append(b)
                    print(f'Account created for {name} with account number {b.account_number}')
                
            else:
                print('Continue with the transaction')


            print('\n')

        elif choice==2:
            yes_no=input('Do you want to deposit amount? (yes/no)')
            if yes_no=='yes':
                print('Deposit Account')
                account=input('enter your account number: ')
                try:
                    find_acc= findAccount(account)
                    if find_acc:
                        amount=int(input('enter your deposit amount: '))
                        find_acc.deposit_amount(amount)

                except DepositAmountError as de:
                    print(de)
                except AccountNumberError as ane:
                    print(ane)
            else:
                print('Continue transaction')

                print('\n')
                
        elif choice==3:
            yes_no=input('Do you want to withdraw amount? (yes/no)')
            if yes_no=='yes':
                print('Withdraw Account')
                account=input('enter your account number: ')
                find_acc= findAccount(account)
                try:
                    if find_acc:
                        amount=int(input('enter withdraw amount: '))
                        find_acc.withdrawamount(amount)
                except WithdrawAmountError as we:
                    print(we)
                except AccountNumberError as ane:
                    print(ane)
            
                print('\n')
            else:
                print('Continue with the transaction.')
                
        elif choice==4:
            print('Your Details')
            account=input('enter your account number: ')
            find_acc= findAccount(account)
            try:
                if find_acc:
                    find_acc.userdetails()
            except AccountNumberError as ane:
                print(ane)

            else:
                print('Continue your transaction.')
            print('\n')

        elif choice==5:
            print('Thank You for choosing us.')
            print('\n')
            break

        else:
            print('Invalid option. Try again')
        
                

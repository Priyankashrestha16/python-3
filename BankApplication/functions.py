from storage import all_accounts
from errorhandling import AccountNumberError



def findAccount(acc_number):
    for accounts in all_accounts:         # accounts represents the each object in all_account[] list
        if accounts.account_number==acc_number:
            return accounts
    return AccountNumberError('Acccount not found. Account Number not match.')
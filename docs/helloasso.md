# HelloAsso

On utilise HelloAsso pour la partie adhésion à l'écothèque, ainsi que les offres de visibilité pour l'écosystème.

On intègre (ou on redirige vers) les formulaires d'adhésion sur la plateforme d'HelloAsso, et on agit en fonction des évènements reçus sur une URL de callback.

## Exemple d'évènement de paiement

```json
{
  "data": {
    "order": {
      "id": 12345678,
      "date": "2024-03-08T15:19:42.2762028+01:00",
      "formSlug": "sample-form-slug",
      "formType": "Membership",
      "organizationName": "My Company",
      "organizationSlug": "my-company",
      "formName": "Sample Form",
      "meta": {
        "createdAt": "0001-01-01T00:00:00+00:00",
        "updatedAt": "0001-01-01T00:00:00+00:00"
      },
      "isAnonymous": false,
      "isAmountHidden": false
    },
    "payer": {
      "email": "contact@example.com",
      "country": "FRA",
      "firstName": "John",
      "lastName": "Smith"
    },
    "items": [
      {
        "id": 87654321,
        "amount": 500,
        "type": "Membership",
        "state": "Processed"
      }
    ],
    "cashOutDate": "0001-01-01T00:00:00+00:00",
    "cashOutState": "Transfered",
    "paymentReceiptUrl": "https://www.helloasso.com/associations/my-company/adhesions/sample-form-slug/paiement-attestation/87654321",
    "id": 12345678,
    "amount": 500,
    "date": "2024-03-08T15:19:41.7523389+01:00",
    "paymentMeans": "Card",
    "installmentNumber": 1,
    "state": "Authorized",
    "meta": {
      "createdAt": "2024-03-08T15:19:03.0111653+01:00",
      "updatedAt": "2024-03-08T15:19:41.8415668+01:00"
    },
    "refundOperations": []
  },
  "eventType": "Payment"
}
```